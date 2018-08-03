class Post < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	has_many :questions, dependent: :destroy
end
