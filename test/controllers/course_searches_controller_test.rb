require 'test_helper'

class CourseSearchesControllerTest < ActionController::TestCase
  setup do
    @course_search = course_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_search" do
    assert_difference('CourseSearch.count') do
      post :create, course_search: {  }
    end

    assert_redirected_to course_search_path(assigns(:course_search))
  end

  test "should show course_search" do
    get :show, id: @course_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_search
    assert_response :success
  end

  test "should update course_search" do
    patch :update, id: @course_search, course_search: {  }
    assert_redirected_to course_search_path(assigns(:course_search))
  end

  test "should destroy course_search" do
    assert_difference('CourseSearch.count', -1) do
      delete :destroy, id: @course_search
    end

    assert_redirected_to course_searches_path
  end
end
