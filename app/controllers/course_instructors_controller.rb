class CourseInstructorsController < ApplicationController
  before_action :set_course_instructor, only: [:show, :edit, :update, :destroy]

  # GET /course_instructors
  # GET /course_instructors.json
  def index
      if(current_user.type==Admin.new.type)
          @course_instructors = CourseInstructor.all
      else 
          if(current_user.type==Instructor.new.type)
              @course_instructors = CourseInstructor.where('user_id=?',current_user.id)
          else
              flash[:danger] = "You are not authorised to view this page!"
              redirect_to current_user
          end
      end
  end

  # GET /course_instructors/1
  # GET /course_instructors/1.json
  def show
      if current_user.type!=Admin.new.type
          flash[:danger] = "You are not authorised to view this page!"
          redirect_to current_user
      end
  end

  # GET /course_instructors/new
  def new
    @course_instructor = CourseInstructor.new
  end

  # GET /course_instructors/1/edit
  def edit
      if current_user.type!=Admin.new.type
          flash[:danger] = "You are not authorised to view this page!"
          redirect_to current_user
      end
  end

  # POST /course_instructors
  # POST /course_instructors.json
  def create
    @course_instructor = CourseInstructor.new(course_instructor_params)
    @collidingcourses = CourseInstructor.where("course_id=? and user_id=?",course_instructor_params[:course_id],course_instructor_params[:user_id])
    if(@collidingcourses.size!=0)
        @collidingcourses.each do |old|
            if( @course_instructor.startdate>@course_instructor.enddate || (@course_instructor.enddate>old.startdate && @course_instructor.startdate<old.enddate))
                flash.now[:danger] = "Overlapping course schedule."
                render :new
                return
            end
        end
    end
    respond_to do |format|
        if @course_instructor.save
            format.html { redirect_to @course_instructor, notice: 'Course instructor was successfully created.' }
            format.json { render :show, status: :created, location: @course_instructor }
        else
            format.html { render :new }
            format.json { render json: @course_instructor.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /course_instructors/1
  # PATCH/PUT /course_instructors/1.json
  def update
    respond_to do |format|
      if @course_instructor.update(course_instructor_params)
        format.html { redirect_to @course_instructor, notice: 'Course instructor was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_instructor }
      else
        format.html { render :edit }
        format.json { render json: @course_instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_instructors/1
  # DELETE /course_instructors/1.json
  def destroy
  	begin
  	Material.where('course_instructor_id=?',@course_instructor.id).destroy_all
    @course_instructor.destroy
    respond_to do |format|
      format.html { redirect_to course_instructors_url, notice: 'Course instructor was successfully destroyed.' }
      format.json { head :no_content }
    end
    rescue ActiveRecord::StatementInvalid
      flash[:danger] = "Instructor has references. Unable to delete."
     redirect_to course_instructors_url 
    end
  end

	def add_material
		@material = Material.new
		@material.course_instructor_id = params[:id]
		@material.material = ""
		@material.save
		redirect_to edit_material_url @material.id
	
		#redirect_to course_instructors_url
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_instructor
      @course_instructor = CourseInstructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_instructor_params
      params.require(:course_instructor).permit(:user_id, :course_id, :startdate, :enddate, :status)
    end
end
