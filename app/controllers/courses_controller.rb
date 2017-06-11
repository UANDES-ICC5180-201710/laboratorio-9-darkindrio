class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    puts @courses[0].isLike(current_person.id)
    
    if params[:title]
      @courses = @courses.where("lower(title) like ?", "%#{params[:title]}%")
    end
  end


  def idLikeForTheCurrentUser(course_id)
    currentLike = LikeTest.where(course_id: course_id, person_id: current_person.id).take
    if currentLike
      return true
    else
      return false
    end 
  end


  # GET /courses/1
  # GET /courses/1.json
  def show
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
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addLike
    course_id = params[:course_id]

    @currentLike = LikeTest.where(course_id: course_id, person_id: current_person.id).take
    if @currentLike
      @currentLike.destroy
      respond_to do |format|
        format.json { render json: {"state" => "success", "isLike" => "false"}}
        format.json { head :no_content }
      end
    else
      current_course = Course.find(course_id)
      @newLike = LikeTest.new
      @newLike.person_id = current_person.id
      @newLike.course_id = course_id
      respond_to do |format|
        if @newLike.save
          format.json { render json: {"state" => "success", "isLike" => "true"}}
        else
          format.json { render json: {"state" => "error", "isLike" => "error"}}
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      teacher_id = params.require(:course)[:teacher]
      if teacher_id
        teacher = Person.find(teacher_id)
      else
        teacher = nil
      end

      params.require(:course).permit(
        :title, :code, :quota
      ).merge(:teacher => teacher)
    end
end
