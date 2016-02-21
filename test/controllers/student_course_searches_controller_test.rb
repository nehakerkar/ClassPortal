require 'test_helper'

class StudentCourseSearchesControllerTest < ActionController::TestCase
  setup do
    @student_course_search = student_course_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_course_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_course_search" do
    assert_difference('StudentCourseSearch.count') do
      post :create, student_course_search: {  }
    end

    assert_redirected_to student_course_search_path(assigns(:student_course_search))
  end

  test "should show student_course_search" do
    get :show, id: @student_course_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student_course_search
    assert_response :success
  end

  test "should update student_course_search" do
    patch :update, id: @student_course_search, student_course_search: {  }
    assert_redirected_to student_course_search_path(assigns(:student_course_search))
  end

  test "should destroy student_course_search" do
    assert_difference('StudentCourseSearch.count', -1) do
      delete :destroy, id: @student_course_search
    end

    assert_redirected_to student_course_searches_path
  end
end
