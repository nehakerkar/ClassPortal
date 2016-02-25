class CourseStudentsController < ApplicationController
  before_action :set_course_student, only: [:update, :destroy]

  # GET /course_students
  # GET /course_students.json
  def index
  	if(current_user.type==Admin.new.type)
	    @course_students = CourseStudent.all
    else 
    	if(current_user.type==Instructor.new.type)
    	@course_students = CourseStudent.where('course_instructor_id IN (?)',CourseInstructor.where('user_id=?',current_user.id).ids)
    	else
    	@course_students = CourseStudent.where('user_id=?',current_user.id)
    	end
    end
  end

  # GET /course_students/1
  # GET /course_students/1.json
  def show
      if current_user.type==Student.new.type && current_user.id!=CourseStudent.find(params[:id]).user.id
          flash[:danger] = "Action not allowed!"
          redirect_to user_path(current_user.id)
          return
      end
      if current_user.type==Instructor.new.type && current_user.id!=CourseStudent.find(params[:id]).course_instructor.user.id
          flash[:danger] = "Action not allowed!"
          redirect_to user_path(current_user.id)
          return
      end
      set_course_student
  end

  # GET /course_students/new
  def new
    @course_student = CourseStudent.new
  end

  # GET /course_students/1/edit
  def edit
      if current_user.type==Student.new.type || (current_user.type==Instructor.new.type && current_user.id!=CourseStudent.find(params[:id]).course_instructor.user.id)
          flash[:danger] = "Action not allowed!"
          redirect_to user_path(current_user.id)
          return
      end
      set_course_student
  end

  # POST /course_students
  # POST /course_students.json
  def create
    @course_student = CourseStudent.new(course_student_params)
    @course_student.user_id = params[:course_student][:user_id]
    @course_student.course_instructor_id = params[:course_student][:course_instructor_id]
    @course_student.grades = ""
    @course_student.status = params[:course_student][:status]
    begin
    respond_to do |format|
      if @course_student.save
        format.html { redirect_to @course_student, notice: 'Course student was successfully created.' }
        format.json { render :show, status: :created, location: @course_student }
      else
        format.html { render :new }
        format.json { render json: @course_student.errors, status: :unprocessable_entity }
      end
      end
    rescue ActiveRecord::RecordNotUnique
    	flash[:danger] = "Student already added to course."
    	redirect_to new_course_student_path
    end
  end

  # PATCH/PUT /course_students/1
  # PATCH/PUT /course_students/1.json
  def update
    @course_student.course_instructor_id = params[:course_student][:course_instructor_id]
    @course_student.grades = params[:course_student][:grades]
    @course_student.status = params[:status]
    respond_to do |format|
      if @course_student.update(course_student_params)
        format.html { redirect_to current_user, notice: 'Course student was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: @course_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_students/1
  # DELETE /course_students/1.json
  def destroy
    @course_student.destroy
    respond_to do |format|
      format.html { redirect_to course_students_url, notice: 'Student was successfully removed from course' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_student
      @course_student = CourseStudent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_student_params
      params.require(:course_student).permit(:user_id, :course_instructor_id, :grades, :status)
    end
end
