require 'test_helper'

class CourseStudentsControllerTest < ActionController::TestCase
  setup do
    @course_student = course_students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_student" do
    assert_difference('CourseStudent.count') do
      post :create, course_student: { course_instructor_id: @course_student.course_instructor_id, grades: @course_student.grades, status: @course_student.status, user_id: @course_student.user_id }
    end

    assert_redirected_to course_student_path(assigns(:course_student))
  end

  test "should show course_student" do
    get :show, id: @course_student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_student
    assert_response :success
  end

  test "should update course_student" do
    patch :update, id: @course_student, course_student: { course_instructor_id: @course_student.course_instructor_id, grades: @course_student.grades, status: @course_student.status, user_id: @course_student.user_id }
    assert_redirected_to course_student_path(assigns(:course_student))
  end

  test "should destroy course_student" do
    assert_difference('CourseStudent.count', -1) do
      delete :destroy, id: @course_student
    end

    assert_redirected_to course_students_path
  end
end
