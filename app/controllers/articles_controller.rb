class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	#avoid the problem that get to the edit page by typing the edit url
	before_action :require_user, except: [:index, :show] 
	before_action :require_same_user, only: [:edit, :update, :destroy] #this is a private method, no need to define in application controller
	def index
		#@articles = Article.all
		@articles = Article.paginate(page: params[:page], per_page: 3)
	end

	def new
       @article = Article.new
	end

	def create
		#render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.user = current_user 
		if @article.save
			#flash[:notice] = "Article was successfully created" change the notice name to fit the bootrape alert style
			flash[:success] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end

	def show
		#@article = Article.find(params[:id])
		@article_comments = @article.comments.paginate(page: params[:page], per_page: 4)
		@new_comments = @article.comments.new
	end

	def edit
		#@article = Article.find(params[:id])
	end

	def update
		#@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		#@article = Article.find(params[:id])
		@article.destroy
		flash[:danger] = "Article was successfully deleted"
		redirect_to articles_path
	end

	private
	   #reduce redundancy
	   def set_article
	   	 @article = Article.find(params[:id])
	   end
	   #to get the title and des of specific article based on the format of inspect
	   def article_params
          params.require(:article).permit(:title, :description, tag_ids:[])  #[]means the array
	   end

	   def require_same_user
	   	  if current_user != @article.user and !current_user.admin?
	   	  	flash[:danger] = "You are not the owner !"
	   	  	redirect_to root_path
	   	  end
	   end
end
