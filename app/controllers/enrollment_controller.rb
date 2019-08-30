class EnrollmentController < ApplicationController
  before_action :authenticate


  def edit
    # get for removing
    variable
  end

  def show
    # basically index
    variable
  end

  def update
    variable
    @course = Course.find(params[:id])
    u_ids = params[:user_list].keys.to_a
    u_ids.each do |u|
      @user = User.find(u)
      @user.courses.delete(@course.id)
    end
    redirect_to enrollment_path(params[:id])
  end

  def new
    @c_id = params[:id]
    @enrollments = Enrollment.where(course_id: params[:id]).select(:user_id)
    enrolls = []
    @enrollments.each {|e| enrolls << e.user_id}
    if enrolls
      @users = User.all.select {|u| u unless enrolls.include? u.id}
    end
  end

  def create
    curr_course = Course.find(params[:id])
    u_ids = params[:user_list].keys
    u_ids.each do |u|
      curr_user = User.find(u)
      Enrollment.create!(course_id: curr_course.id, user_id: curr_user.id, created_at: Time.current, updated_at: Time.current)
    end
    redirect_to enrollment_path(params[:id])
  end

  def variable
    @c_id = params[:id]
    @enrollments = Enrollment.where(course_id: params[:id]).select(:user_id)
    enrolls = []
    @enrollments.each {|e| enrolls << e.user_id}
    if enrolls
      @users = User.all.select {|u| u if enrolls.include? u.id}
    end
  end

end
