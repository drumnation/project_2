class SubmissionsController < ApplicationController


	def new
		@submission = Submission.new
	end

	def create
		@submission = Submission.new(submission_params)
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


	def index
		@submissions = Submission.all.shuffle
	end

	def show
		@submission = Submission.find(params[:id])
	end


	private

	def submission_params
		params.require(:submission).permit(:title, :url, :description)
	end


end