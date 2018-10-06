class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         # :registerable,
  has_one :customer
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :departments
  has_many :organizations, through: :groups
  has_one :customer_profile
  has_one_attached :profile_image

  def as_json(options={})
      super.as_json(options).merge({full_name: full_name, profile_image: self.profile_image.service_url})
  end

  def full_name
    "#{first_name} #{last_name}".squish
  end
end
