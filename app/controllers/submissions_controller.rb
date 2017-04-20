class SubmissionsController < ApplicationController
	before_filter :authorize, except: [:index, :show, :create, :destroy]

	def index
		@submissions = Submission.all.shuffle
	end

	def show
		@submission = Submission.find(params[:id])
		@comment = Comment.new
	end

	def new
		@submission = Submission.new
	end

	def create
		page = MetaInspector.new(submission_params[:url])
		img = page.images.best
		@submission = Submission.new(submission_params)
		@submission.image = img
		@submission.user_id = session[:user_id]
		if @submission.save
			redirect_to submission_path(@submission)
		else
			render 'new'
		end
	end

	def edit
		@submission = Submission.find(params[:id])
	end

	def update
		@submission = Submission.find(params[:id])
		if @submission.update(submission_params)
			redirect_to submission_path(@submission)
		else
			render 'edit'
		end
	end

	def destroy
		Submission.find(params[:id]).destroy
		flash[:success] = "POST DELETED...How could you?"
		redirect_to root_path
	end

	private

	def submission_params
		params.require(:submission).permit(:title, :url, :description, :user_id)
	end


end
