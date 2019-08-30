# frozen_string_literal: true

require 'hashids'
# Office Hours controller
class OfficeHoursSessionController < ApplicationController
  before_action :authenticate

  def show
    if OfficeHoursSession.exists? id: params[:id]
      @oh = OfficeHoursSession.find(params[:id])
      @questions = @oh.questions
      @users = User.all
      @id = params[:id]
      @roles = { ta_role: Role.find_by_role_name('ta').id, student_role: Role.find_by_role_name('student').id }
      @course = Course.find @oh.course_id
    else
      flash[:warning] = 'No such office hours session'
      redirect_to home_path
    end
  end

  def create
    c = Course.find params[:course_id]
    hashy = Hashids.new Time.current.to_s
    uuid = hashy.encode(c.id, Time.current.to_i)
    oh = c.office_hours_sessions.build(start_time: Time.current, uuid: uuid)
    oh.save!
    redirect_to office_hours_session_path(oh.id)
  end
end
