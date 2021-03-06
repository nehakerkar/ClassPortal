class AdminsController < ApplicationController
  before_action :set_admin, only: [:update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
      if(current_user.type==Admin.new.type)
          @admins = Admin.all
      else
          flash[:danger]= "You are not authorized to view this page!"
          redirect_to current_user
      end
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
      if User.find(params[:id]).type!=Admin.new.type
          redirect_to current_user
          return
      end
      if(Admin.new.type== current_user.type && params[:id].to_f==current_user.id)
          set_admin
      else
          flash[:danger] = "Trespassers will be prosecuted!"
          redirect_to user_path(current_user.id)
      end
  end

  def view_instructor_history
  	if(current_user.type==Admin.new.type)
    	@course_instructors = CourseInstructor.all
    else
    	flash[:danger]= "You are not authorized to view this page!"
    	redirect_to current_user
    end
  end
  
  def view_student_history
  	if(current_user.type==Admin.new.type)
    	@course_students = CourseStudent.all
    else
    	flash[:danger]= "You are not authorized to view this page!"
    	redirect_to current_user
    end
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
      if User.find(params[:id]).type!=Admin.new.type
          redirect_to current_user
          return
      end
      if current_user.type == Admin.new.type && (current_user.deleteable == false || current_user.deleteable==Admin.find(params[:id]).deleteable)
          set_admin
      else
          flash[:danger] = "You are not authorized to edit this page!"
          redirect_to current_user
      end
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)
    @admin.deleteable = true
    respond_to do |format|
      if @admin.save
        format.html { redirect_to current_user, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to current_user, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
  	if(!@admin.deleteable || @admin.id==current_user.id || current_user.type!=Admin.new.type)
  		flash[:danger] = "Operation not allowed! Admin can't be deleted."
  		redirect_to admins_url
  		return
  	end
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def view_inactive_requests
		@course_instructors = CourseInstructor.where("status=?",'pending')
	end
	
	def make_inactive
		if(current_user.type == Admin.new.type)
			@course_instructor = CourseInstructor.find(params[:id])
			@course_instructor.update(status: 'inactive')
			flash[:notice] = "Course '" + @course_instructor.course.title + "' inactive."
			redirect_to view_inactive_requests_admins_path
		else
			flash[:danger] = "You are not authorized to edit this page!"
          	redirect_to current_user
		end
	end
	
	def make_active
	if(current_user.type == Admin.new.type)
			@course_instructor = CourseInstructor.find(params[:id])
			@course_instructor.update(status: 'active')
			flash[:notice] = "Course '" + @course_instructor.course.title + "' active."
			redirect_to view_inactive_requests_admins_path
		else
			flash[:danger] = "You are not authorized to edit this page!"
          	redirect_to current_user
		end
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
		params.require(:admin).permit(:email, :name, :password, :password_confirmation, :type, :deleteable)    
	end
end
