class Role < ActiveRecord::Base
  has_many :users

  validates :role_name, presence: true,
            length: {maximum: 15}

  @@PRIVALIGE_HASH = {
    admin: %i[admin professor ta student],
    professor: %i[ta student],
    ta: [],
    student: []
  }

  def self.get_editable_roles(u_id)
    avail_roles_symbols = @@PRIVALIGE_HASH[Role.find(User.find(u_id).role_id).role_name.to_sym]
    Role.all.select { |r| avail_roles_symbols.include? r.role_name.to_sym }
  end
end
