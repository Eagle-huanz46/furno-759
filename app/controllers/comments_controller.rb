class CommentsController < ApplicationController
	before_action :set_comment, only: [:edit, :update, :destroy]
	before_action :require_user, except: [:show] 
	before_action :require_same_user, only: [:edit, :update, :destroy]
	def index
		@comments = Comment.where(user_id: current_user).order("updated_at DESC").paginate(page: params[:page], per_page: 4)
	end

	def new
       
	end

	def create
		@comment = Comment.new(comment_params)

		if @comment.save
			flash[:success] = "Comment was successfully created"
			redirect_back(fallback_location: root_path)
		else
			flash[:danger] = "Comment cannot be blank or less than 10 words !"
			redirect_back(fallback_location: root_path)
		end
	end


	def show
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			flash[:success] = "Comment was successfully updated"
			redirect_to comments_path
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		flash[:danger] = "Comment was successfully deleted"
		redirect_back(fallback_location: root_path)
	end

	private
	   def set_comment
	   	 @comment = Comment.find(params[:id])
	   end
	   def comment_params
          params.require(:comment).permit(:context, :user_id, :article_id) 
	   end
	   
	   def require_same_user
	   	  if current_user != @comment.user and !current_user.admin?
	   	  	flash[:danger] = "You are not the owner !"
	   	  	redirect_to root_path
	   	  end
	   end
end
