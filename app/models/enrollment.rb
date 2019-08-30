class Enrollment < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :course, optional: true

  # User and course objects present in other tables
  validates :user, presence: true
  validates :course, presence: true

  # Maintain each pairing uniqueness
  validates :user_id, uniqueness: {scope: :course_id}
end

