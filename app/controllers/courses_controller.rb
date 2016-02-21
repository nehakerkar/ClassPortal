class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy,]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  def search
    @courseinstrobjects = []
    @flag = 0
    logger.debug(params.to_s)
    if params[:course_number] != ""
      logger.debug("1")
      @courseinstrobjects += CourseInstructor.where(:course_id => Course.where(:coursenumber => params[:course_number]).ids)
      @flag = 1
    end
    if params[:course_title]!= ""
      logger.debug("2")
      @courseinstrobjects += CourseInstructor.where(:course_id => Course.where(:title => params[:course_title]).ids)
      @flag = 1
    end
    if params[:course_description]!= ""
      logger.debug("3")
      @courseinstrobjects += CourseInstructor.where(:course_id => Course.where(:description => params[:course_description]).ids)
      @flag = 1
    end
    if params[:course_instructor]!= ""
      logger.debug("4")
      @courseinstrobjects += CourseInstructor.where(:user_id => User.where(:name => params[:course_instructor]).ids)
      @flag = 1
    end
    if params[:course_status]!= ""
      logger.debug("5")
      @courseinstrobjects += CourseInstructor.where(:status => params[:course_status])
      @flag = 1
    end

    if @courseinstrobjects.size == 0 and @flag == 0

      @courseinstrobjects = CourseInstructor.where(:status => "active")
    end
    @courseinstrobjects = @courseinstrobjects.uniq
  end

  def displayenrollrequest
    @courses = Course.where(:coursenumber => params[:course_number]).first(1)
    @student = User.find(params[:student_id])
    @course_instr = CourseInstructor.find(params[:course_instr_id])
    CourseStudent.create(:user_id => @student.id, :course_instructor_id => @course_instr.id, :status => :pending)
    @courses
  end

  def droprequest
    CourseStudent.delete(params[:course_student_id])
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    if (@course.course_instructors.length > 0)
    	flash[:danger] = "Course has references. Unable to delete!"
		redirect_to courses_path
		return
    end
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :coursenumber, :description)
    end
end
