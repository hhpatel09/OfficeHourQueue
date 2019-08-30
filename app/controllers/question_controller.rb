class QuestionController < ApplicationController
  before_action :authenticate

  def new
    only_student
    if OfficeHoursSession.exists? id: params[:office_hours_session_id]
      questions = OfficeHoursSession.find(params[:office_hours_session_id]).questions
      unless questions.blank?
        questions.each do |q|
          if q.student_id == current_user.id # this was originally current_user.id0, was that correct?
            flash[:warning] = 'User cannot add multiple questions to same queue'
            redirect_to office_hours_session_path(params[:office_hours_session_id])
          end
        end
      end
      @users = User.all
    else
      redirect_to home_path
    end
  end

  def create
    only_student
    if params[:question].blank?
      flash[:warning] = 'Question can not be empty'
      redirect_to office_hours_session_path(params[:office_hours_session_id])
    else
      question_info = {question_text: params[:question], office_hours_session_id: params[:office_hours_session_id], course_id: params[:course_id], current_user: @current_user.id}
      flash[:warning] = 'Question cannot exceed 200 characters' unless Question.add_question!(question_info)
      redirect_to office_hours_session_path(params[:office_hours_session_id])
    end
  end

  def edit
    only_student
    if Question.exists? id: params[:id]
      @question_info = Question.find(params[:id]).question_text
    else
      flash[:warning] = 'Question does not exist.'
      redirect_to office_hours_session_path
    end

    redirect_to office_hours_session_path unless Question.find(params[:id]).student_id == @current_user.id
  end

  def update
    only_student
    if Question.exists? id: params[:id]
      question = Question.find params[:id]
      tgh = question.update_attributes question_text: params[:question]
      flash[:warning] = 'Question cannot exceed 200 characters or be blank' unless tgh
    end
    if OfficeHoursSession.exists? id: params[:office_hours_session_id]
      redirect_to office_hours_session_path(params[:office_hours_session_id])
    else
      redirect_to home_path
    end
  end

  def destroy

    begin
      @question = Question.find(params[:id])
      office_hours_session = @question.office_hours_session_id
      @question.destroy
      flash[:notice] = 'Question was deleted.'
      redirect_to office_hours_session_path(office_hours_session)
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'Question does not exist.'
      if OfficeHoursSession.exists? id: params[:office_hours_session_id]
        redirect_to office_hours_session_path(params[:office_hours_session_id])
      else
        redirect_to home_path
      end
    end
  end
end
