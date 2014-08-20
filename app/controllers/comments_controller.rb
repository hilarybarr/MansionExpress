class CommentsController < ApplicationController
	before_action :set_comment, except: [:create]
	def index
		@comment = Comment.all
	end


	def show
		
	end

	def new
		@comment = Comment.new
	end


	def create
		@comment = Comment.new(comment_params)
		respond_to do |format|
		  if @comment.save
		    format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
		  else
		    format.json { render json: @comment.errors, status: :unprocessable_entity }
		  end
		end
	end

	private

	def set_comment
	  @comment = Comment.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def comment_params
	  params[:comment]
	end
end
