class User < ApplicationRecord
has_person_name
validates_uniqueness_of :username

has_many :tweets

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_one_attached :profile_image
end
