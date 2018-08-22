class Post < ActiveRecord::Base
	enum status: {ing: 0, done: 1}
	has_many :answers, dependent: :destroy
	has_many :questions, dependent: :destroy
	belongs_to :user
	resourcify
end
