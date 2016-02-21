require 'test_helper'

class StudentCourseSearchControllersControllerTest < ActionController::TestCase
  setup do
    @student_course_search_controller = student_course_search_controllers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_course_search_controllers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_course_search_controller" do
    assert_difference('StudentCourseSearchController.count') do
      post :create, student_course_search_controller: {  }
    end

    assert_redirected_to student_course_search_controller_path(assigns(:student_course_search_controller))
  end

  test "should show student_course_search_controller" do
    get :show, id: @student_course_search_controller
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student_course_search_controller
    assert_response :success
  end

  test "should update student_course_search_controller" do
    patch :update, id: @student_course_search_controller, student_course_search_controller: {  }
    assert_redirected_to student_course_search_controller_path(assigns(:student_course_search_controller))
  end

  test "should destroy student_course_search_controller" do
    assert_difference('StudentCourseSearchController.count', -1) do
      delete :destroy, id: @student_course_search_controller
    end

    assert_redirected_to student_course_search_controllers_path
  end
end
