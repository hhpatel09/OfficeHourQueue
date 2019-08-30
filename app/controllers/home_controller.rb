# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate, except: :show

  def show
    # landing page for all users
  end

  def index
    # logged in user page
    @role = Role.find(@current_user.role_id)
    # replace this so that only courses a student is involved in and queues that are active are shown
    @office_hours = OfficeHoursSession.all
    @admin_button = false
    @oh_button = false
    @admin_button = true if %w[admin professor].include? @role.role_name
    @oh_button = true if @admin_button || (@role.role_name == 'ta')
    @courses = Course.all
  end

  def join_queue
    if params[:queue_id].blank?
      flash[:warning] = 'Queue ID cannot be blank.'
      redirect_to home_path
    else
      begin
        temp_session = OfficeHoursSession.find_by(uuid: params[:queue_id])
        unless temp_session.nil?
          redirect_to office_hours_session_path(temp_session)
        end
        if temp_session.nil?
          flash[:warning] = "#{params[:queue_id]} is not a valid queue id"
          redirect_to home_path
        end
      rescue ActiveRecord::RecordNotFound
        flash[:warning] = "#{params[:queue_id]} is not a valid queue id"
        redirect_to home_path
      end
    end
  end

end
