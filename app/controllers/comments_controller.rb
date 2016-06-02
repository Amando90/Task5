class CommentsController < ApplicationController
	before_action :set_post
	
	def index
	    @comments = Comment.order('created_at DESC')

	    respond_to do |format|
	      format.html
	      format.xlsx {
	        response.headers['Content-Disposition'] = 'attachment; filename="all_comments.xlsx"'
	      }
	    end
	end

	def create
		@comment = @post.comments.build(comment_params)
		
		if @comment.save
			flash[:success] = "Comment successfully added."
			redirect_to :back
		else
			flash[:alert] = "Sorry, something went wrong"
			render root_path
		end

	end

	def destroy
		@comment = @post.comments.find(params[:id])

		@comment.destroy
		flash[:success] = "Comment deleted"
		redirect_to root_path
	end


	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def set_post
		@post = Post.find(params[:post_id])
	end
end
