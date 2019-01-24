class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         # :registerable,
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :departments
  has_many :push_notification_posts
  has_many :push_notifications, through: :push_notification_posts
  has_many :organizations, through: :groups
  has_many :basic_forms
  has_many :locations
  has_one :customer_profile  
  has_one_attached :profile_image


  def as_json(options={})
      pic_url = self.profile_image.attached? ? self.profile_image.service_url : 'https://s3-us-west-1.amazonaws.com/kitfoxdesign/unknown.jpg'
      super.as_json(options).merge({full_name: full_name, profile_image: pic_url})
  end

  def full_name
    "#{first_name} #{last_name}".squish
  end
end
