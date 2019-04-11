class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy, :list_comment]
	before_action :require_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome! #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
		#to display the user's articles but not user in pagination, we need to define it
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Account was successfully updated"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		flash[:danger] = "User and all articles were successfully deleted"
		redirect_to users_path
	end

	def list_comment
		@all_comments = @user.comments.all.paginate(page: params[:page], per_page: 4)
	end

	private
	   def set_user
	   	 @user = User.find(params[:id])
	   end
	   def user_params
          params.require(:user).permit(:username, :email, :password)
	   end
	   def require_same_user
	   	  if current_user != @user and !current_user.admin?
	   	  	flash[:danger] = "You can only edit your own account !"
	   	  	redirect_to root_path
	   	  end
	   end
	   
end
