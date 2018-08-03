class Answer < ActiveRecord::Base
	belongs_to :post
	has_many :items, dependent: :destroy
end
