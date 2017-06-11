class Interest < ApplicationRecord
	belongs_to :people, class_name: 'Person', foreign_key: 'person_id'
	belongs_to :course, class_name: 'Course', foreign_key: 'course_id'

	validates_uniqueness_of :curse_id, :scope => :person_id
end
