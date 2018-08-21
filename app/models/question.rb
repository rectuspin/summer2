class Question < ActiveRecord::Base
	has_many :selections, dependent: :destroy
	belongs_to :post
	resourcify
end
