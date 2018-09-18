class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :customer
  belongs_to :group
  has_and_belongs_to_many :departments
  has_one :organization, through: :group
  has_one :customer_profile

  def full_name
    "#{first_name} #{last_name}".squish
  end
end
