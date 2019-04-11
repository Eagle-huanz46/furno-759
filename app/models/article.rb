class Article < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :article_tags
	has_many :tags, through: :article_tags
	validates :title, presence:true, length:{minimum: 3, maximum: 50}
	validates :description, presence:true, length:{minimum:10, maximum:300}
	validates :user_id, presence:true
end