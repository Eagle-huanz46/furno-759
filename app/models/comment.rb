class Comment < ApplicationRecord
	belongs_to :user
	validates :context, presence:true, length:{minimum:10, maximum:300}
	validates :user_id, presence:true
	validates :article_id, presence:true
end