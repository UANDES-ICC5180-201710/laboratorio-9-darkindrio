class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments
  belongs_to :teacher, class_name: 'Person', foreign_key: 'person_id'
  has_many :likes
  has_many :like_tests

  validates :teacher, presence: true

  validates :title, {
    length: { minimum: 3,  maximum: 30 },
    presence: true,
    uniqueness: true,
  }

  validates :code, {
    length: { minimum: 3,  maximum: 10 },
    presence: true,
    uniqueness: true,
  }

  validates :quota, {
    presence: true,
    numericality: true,
  }

  def to_s
    return title
  end

  def isLike(p_id)
    currentLike = LikeTest.where(course_id: id, person_id: p_id).take
    if currentLike
      return true
    else
      return false
    end
  end
end
