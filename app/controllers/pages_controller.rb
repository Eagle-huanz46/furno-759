class PagesController < ApplicationController
	def home
		#if user logined, show the articles page but not the jumbotron
		redirect_to articles_path if login?
	end
end
