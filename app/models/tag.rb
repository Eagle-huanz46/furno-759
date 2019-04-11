class Tag < ApplicationRecord
	has_many :article_tags
	has_many :articles, through: :article_tags
	validates :name, presence:true, uniqueness: true, length:{maximum: 25}
    #validates_uniqueness_of :name
end