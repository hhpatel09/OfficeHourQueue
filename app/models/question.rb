class Question < ActiveRecord::Base
  belongs_to :student, class_name: 'User'
  belongs_to :instructor, class_name: 'User', optional: true
  belongs_to :course, optional: true
  belongs_to :office_hours_session, optional: true

  validates :question_text, presence: true,
                            length: {maximum: 200}
  validates :time_added, presence: true
  validates :time_started, presence: false
  validates :time_completed, presence: false

  validates_associated :student
  #validates_associated :instructor
  #validates_associated :course
  #validates_associated :office_hours_session

  def self.add_question!(q_params)
    q = Question.create(question_text: q_params[:question_text], time_added: Time.current)
    q.student_id = q_params[:current_user]
    q.office_hours_session_id = q_params[:office_hours_session_id]
    q.course_id = q_params[:course_id]
    # Make sure to add to sessions when its time
    begin
      q.save!
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

end
