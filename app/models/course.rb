class Course < ActiveRecord::Base
  has_many :office_hours_sessions
  has_many :questions
  has_many :enrollments
  has_many :users, through: :enrollments, dependent: :destroy

  validates :department_name, presence: true,
                              length: {maximum: 8}
  validates :course_number, presence: true,
                            length: {maximum: 8}
  validates :course_name, presence: true,
                          length: {maximum: 50}
  validates :semester, presence: true,
                       length: {in: 6..15}
end
