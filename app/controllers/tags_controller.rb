class TagsController < ApplicationController
	before_action :set_tag, only: [:show, :edit, :update]
	before_action :require_admin, except: [:index, :show]
	def index
		@tags = Tag.paginate(page: params[:page], per_page: 5)
	end

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.new(tag_params)
		if @tag.save
			flash[:success] = "Tag was successfully created"
			redirect_to tags_path
		else
			render 'new'
		end
	end

	def show
		@tag_articles = @tag.articles.paginate(page: params[:page], per_page: 3)
	end

	def edit
	end

	def update
		if @tag.update(tag_params)
			flash[:success] = "Tag was successfully updated"
			redirect_to tag_path(@tag)
		else
			render 'edit'
		end
	end

	private 
	  def set_tag
	  	@tag = Tag.find(params[:id])
	  end

	  def tag_params
	  	params.require(:tag).permit(:name)
	  end
end
