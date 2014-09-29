class Contact < ActiveRecord::Base
  validates :user_id, presence: true
  validates :email, presence: true, uniqueness: {scope: :user_id}

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :contact_shares
  has_many :shared_users, through: :contact_shares, source: :user
end