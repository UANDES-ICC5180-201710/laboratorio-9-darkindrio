class Like < ApplicationRecord
  belongs_to :course_id, class_name: 'Course',foreign_key: 'course_id_id'
  belongs_to :student_id, class_name: 'Person'

  validates_uniqueness_of :course_id, :scope => :student_id
end
