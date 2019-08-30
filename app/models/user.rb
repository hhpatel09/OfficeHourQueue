class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth)
    admin_emails = %w[claire.co36@gmail.com cooper.bell56@gmail.com hans.j.johnson@gmail.com
              hhpatel09@gmail.com jason.w.ryan9@gmail.com powersa15@gmail.com]

    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.picture = auth.info.image
      if user.role_id.nil?
        if admin_emails.include? user.email
          user.role_id =Role.find_by(role_name: 'admin').id
        else
          user.role_id = Role.find_by(role_name: 'student').id  # Default to student role
        end
      end
      if user.session_token.nil?
        user.session_token = SecureRandom.base64
      end
      user.save!
    end
  end

  belongs_to :role
  has_many :asked_questions, class_name: 'Question', foreign_key: 'student_id'
  has_many :answered_questions, class_name: 'Question', foreign_key: 'instructor_id'
  has_many :enrollments
  has_many :courses, through: :enrollments, dependent: :destroy

  validates :first_name, presence: true,
                         length: { maximum: 40 }
  validates :last_name, presence: true,
                        length: { maximum: 40 }
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates_associated :role

  # privalige_id must be a Role primary key
  def self.get_editable_users(privalige_id)
    editable_roles = Role.get_editable_roles(privalige_id)
    User.all.select { |u| editable_roles.include? Role.find(u.role_id) }
  end

  def self.permission_to_edit?(editor_id, editee_id)
    Role.get_editable_roles(editor_id).include? Role.find(User.find(editee_id).role_id)
  end

  def self.update_role!(u_id, r_id)
    u = User.find(u_id)
    u.role_id = r_id
    u.save!
  end
end
