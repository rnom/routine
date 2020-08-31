class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :bodyweight, presence: true
  validates :height, presence: true
  validates :age, presence: true
  validates :pal, presence: true

  has_many :favorites, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save do
    bmr = 10 * bodyweight + 6.25 * height - 5 * age + 5
    self.bmr = bmr.round(0)

    tdee = bmr * pal
    self.tdee = tdee.round(0)
  end

  before_update do
    bmr = 10 * bodyweight + 6.25 * height - 5 * age + 5
    self.bmr = bmr.round(0)

    tdee = bmr * pal
    self.tdee = tdee.round(0)
  end

end
