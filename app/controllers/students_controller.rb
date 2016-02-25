class StudentsController < ApplicationController
  before_action :set_student, only: [:update, :destroy]

  # GET /students
  # GET /students.json
  def index
    if(Admin.new.type== current_user.type)
    	@students = Student.all
    else
    	flash[:danger] = "You are not authorized to view this page!"
    	redirect_to user_path(current_user.id)
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
      if current_user.type!=Student.new.type || current_user.id != params[:id].to_f
          flash[:danger] = "You are not authorized to view this page!"
          redirect_to user_path(current_user.id)
      else
          set_student
      end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
      if current_user.type==Instructor.new.type || (current_user.type==Student.new.type && current_user.id != params[:id].to_f)
          flash[:danger] = "You are not authorized to view this page!"
          redirect_to user_path(current_user.id)
      else
          set_student
      end
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
	@student.deleteable = true
    respond_to do |format|
      if @student.save
      	log_in @student
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render new_user_path }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
  	CourseStudent.where('user_id=?',@student.id).destroy_all
    @student.destroy
    respond_to do |format|
      format.html { redirect_to admin_path(current_user.id), notice: 'Student was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:email, :name, :password, :password_confirmation, :type, :deleteable)
    end
end
