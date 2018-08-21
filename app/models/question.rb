class Question < ActiveRecord::Base
	enum view_type: {column: 0, bar: 1, pie: 2}
	has_many :selections, dependent: :destroy
	belongs_to :post
	resourcify
end
