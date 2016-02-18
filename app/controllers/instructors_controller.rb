class InstructorsController < ApplicationController
  #before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  # GET /instructors
  # GET /instructors.json
  def index
    if(Admin.new.type== current_user.type)
    	@instructors = Instructor.all
    else
    	redirect_to instructor_path(current_user.id)
    end
  end

  # GET /instructors/1
  # GET /instructors/1.json
  def show
   @instructor= Instructor.find(params[:id])
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
  	@instructor= Instructor.find(params[:id])
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
    @instructor= Instructor.find(params[:id])
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:email, :name, :password, :type, :deleteable)
    end
end
