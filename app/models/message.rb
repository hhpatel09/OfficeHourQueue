class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :office_hours_session

  # User and Office hours session present in other tables
  validates :user, presence: true
  validates :office_hours_session, presence: true

  # Runs validation on user and office hours session
  validates_associated :user
  validates_associated :office_hours_session

  # TODO Validate user is role TA
end
