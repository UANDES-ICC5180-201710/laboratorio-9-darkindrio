class LikeTest < ApplicationRecord
  belongs_to :person
  belongs_to :course
  validates_uniqueness_of :course, :scope => :person
end
