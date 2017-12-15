class User < ActiveRecord::Base
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attendees
  has_many :events_attending, through: :attendees, source: :events

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, presence: true, length: {minimum: 2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :state, presence: true, length: {is: 2}
  validates :password, presence:true, length: {minimum: 8}, on: :create

end
