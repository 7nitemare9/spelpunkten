class PostsController < ApplicationController
	http_basic_authenticate_with name: "bombers", password: "suspensoar", except: :index


	def index
		@posts = Post.all.reverse
	end

	def new
	end

	def create
		@post = Post.new(post_params)
		@post.save
		redirect_to @post
	end

	def show
		@post = Post.find(params[:id])
	end
	
	private
		def post_params
			params.require(:post).permit(:title, :text)
		end

end
