class CourseController < ApplicationController
  before_action :authenticate

  def course_params
    params.permit(:department_name, :course_number, :course_name, :semester)
  end

  def new
    # render form for adding a course
  end

  def update
    @role = Role.find(@current_user.role_id)
    permission = true if %w[admin professor].include? @role.role_name
    if permission && valid_params
      c = Course.find params[:id]
      c.update_attributes!(course_params)
      flash[:notice] = "The course #{c.course_name} has been successfully updated"
    elsif permission &&!valid_params
      flash[:warning] = 'One or more of the fields is incorrect'
      redirect_to(edit_course_path(Course.find(params[:id]))) and return
    else
      flash[:warning] = "Don't have permission to edit course"
    end
    redirect_to course_index_path
  end

  def create
    @role = Role.find(@current_user.role_id)
    permission = true if %w[admin professor].include? @role.role_name
    if permission && valid_params
      c = Course.create!(course_params)
      flash[:notice] = "The course #{c.course_name} has been successfully added"
    elsif permission && !valid_params
      flash[:warning] = 'One or more of the fields is incorrect'
      redirect_to new_course_path and return
    else
      flash[:warning] = "Don't have permission to create course"
    end
    redirect_to course_index_path
  end

  def index
    @courses = Course.all
  end

  def edit
    begin
      @course = Course.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'Invalid Course'
      redirect_to course_index_path
    end
  end

  def show
    begin
      @course = Course.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'Invalid Course'
      redirect_to course_index_path
    end
  end

  def destroy
    if Course.exists? id: params[:id]
      c = Course.find params[:id]
      c.destroy
      flash[:notice] = "Course #{c.course_name} was removed"
    end
    redirect_to course_index_path
  end

  def valid_params
    var = true
    var = false unless course_params[:department_name].is_a? String
    change_to_int = course_params[:course_number].to_i.to_s
    var = false unless course_params[:course_number] == change_to_int
    var = false unless course_params[:course_name].is_a? String
    course_params.each do |k, v|
      var = false if v.blank?
    end
    var
  end
end
