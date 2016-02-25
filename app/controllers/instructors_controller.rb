class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:edit, :update, :destroy]

  # GET /instructors
  # GET /instructors.json
  def index
    if(Admin.new.type== current_user.type)
        @instructors = Instructor.all
    else
        flash[:danger] = "You are not authorized to view this page!"
        redirect_to user_path(current_user.id)
    end
  end

  # GET /instructors/1
  # GET /instructors/1.json
  def show
      if User.find(params[:id]).type!=Instructor.new.type
          redirect_to current_user
          return  
      end
      if Instructor.new.type==current_user.type && current_user.id==params[:id].to_f
          set_instructor
      else
          flash[:danger] = "Unauthorized Operation!"
          redirect_to user_path(current_user.id)
      end
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
      if User.find(params[:id]).type!=Instructor.new.type
          redirect_to current_user
          return  
      end
      if current_user.type==Student.new.type || (current_user.type==Instructor.new.type && current_user.id!=params[:id].to_f)
          flash[:danger] = "Unauthorized Operation!"
          redirect_to current_user
          return
      else
          set_instructor
      end

  end

  # POST /instructors
  # POST /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)
    @instructor.deleteable = true
    respond_to do |format|
      if @instructor.save
        format.html { redirect_to admin_path(current_user), notice: 'Instructor was successfully created.' }
        format.json { render :show, status: :created, location: admin_path(current_user) }
      else
        format.html { render :new }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update
    if(current_user.type=="Admin" && @instructor.update(instructor_params))
      	 flash[:notice] = 'Instructor was successfully updated.'
      	 redirect_to admin_path(current_user.id)
    else
    respond_to do |format|
      if @instructor.update(instructor_params)
        format.html { redirect_to @instructor, notice: 'Instructor was successfully updated.' }
        format.json { render :show, status: :ok, location: @instructor }
      else
        format.html { render :edit }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /instructors/1
  # DELETE /instructors/1.json
  def destroy
    @instructor= Instructor.find(params[:id])
    if(@instructor.course_instructors.length >0)
     flash[:danger] = "Instructor has references. Unable to delete."
     redirect_to instructors_path
     return
    end
    @instructor.destroy
    respond_to do |format|
      format.html { redirect_to admin_path(current_user.id), notice: 'Instructor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def show_pending_students_requests
		if(current_user.type!=Instructor.new.type)
			flash[:danger] = "You are not authorised to view this page!"
			redirect_to current_user
		end
    	@course_students = CourseStudent.where('course_instructor_id IN (?) and status=\'pending\'',CourseInstructor.where('user_id=? and enddate>=?',current_user.id,Time.new.inspect).ids)
	end
	
	def enroll_student
		@course_student = CourseStudent.find(params[:course_student])
		@course_student.update(status: 'enrolled')
		flash[:notice] = "Student enrolled successfully."
		redirect_to instructor_path current_user
	end
	
	def show_enrolled_students_requests
		if(current_user.type!=Instructor.new.type)
			flash[:danger] = "You are not authorised to view this page!"
			redirect_to current_user
		end
		@course_students = CourseStudent.where('course_instructor_id IN (?) and status=\'enrolled\'',CourseInstructor.where('user_id=?',current_user.id).ids)
	end
	
	def unenroll_student
		@course_student = CourseStudent.find(params[:course_student])
		@course_student.destroy
		flash[:notice] = "Student unenrolled successfully."
		redirect_to current_user	
	end
	
	def view_my_students
		@course_students = CourseStudent.where('course_instructor_id IN (?)',CourseInstructor.where('user_id=?',current_user.id).ids)
	end
	
	def change_grades
		if(current_user.type!=Instructor.new.type)
			flash[:danger] = "You are not authorised to view this page!"
			redirect_to current_user
		end
		@course_student = CourseStudent.find(params[:id])
		if(@course_student.course_instructor.startdate>=Time.new.inspect)
			flash[:danger] = "Cannot update grade!"
			redirect_to current_user
			return
		end
		@course_student.update(grades: params[:grades])
		flash[:notice] = "Grade updated for Student "+@course_student.user.name
		redirect_to view_my_students_instructors_path
	end
	
	def view_my_courses
		@course_instructors = CourseInstructor.where("user_id=?",current_user.id)
	end
	
	def add_material
		@material = Material.new
		@material.course_instructor_id = params[:id]
		@material.material = ""
		@material.save
		redirect_to edit_material_url @material
	end
	
	def view_material
		@materials = Material.where('course_instructor_id=?',params[:id])
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:email, :name, :password, :password_confirmation, :type, :deleteable)
    end
end
