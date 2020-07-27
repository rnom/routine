class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :bodyweight, presence: true
  validates :height, presence: true

  has_many :favorites, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save do
    height_2 = height ** 2
    self.bmi = bodyweight.fdiv(height_2)
  end

  before_update do
    height_2 = height ** 2
    self.bmi = bodyweight.fdiv(height_2)
  end

end
