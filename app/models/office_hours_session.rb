class OfficeHoursSession < ActiveRecord::Base
  belongs_to :course
  has_many :questions
  has_many :messages

  # Course present in other table
  validates :course, presence: true
  validates :uuid, uniqueness: true

  # Run validation on course
  validates_associated :course

  validates :start_time, presence: true
  validates :end_time, presence: false
end
