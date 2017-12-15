class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attendees
  has_many :users, through: :attendees

  validates :name, :city, :state, presence: true
  validate :date_validation
  validates :date, presence: true
  private
  def date_validation
    today = Date.today
    unless date == nil
      errors.add(:date, 'Must be a future date') if date <= today
    end
  end

end
