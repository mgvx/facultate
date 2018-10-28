class QuestionsController < ApplicationController
	before_action :verify_access, only: [:edit, :update, :destroy]

	def index
		@questions = Question.search_text(params[:query]).paginate(:page => params[:page], :per_page => 12)
	end

	def show
    @question = Question.find(params[:id])
		@similar_questions = Question.where(id: @question.similar_ids)
	end

	def new
		@question = Question.new
	end

	def create
    @question = Question.new(question_params)
    if @question.save
			@question.update_attribute(:user_id, current_user.id)
      redirect_to @question
    else
      render 'new'
    end
	end

	def edit
    @question = Question.find(params[:id])
	end

	def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
	end

	def destroy
    @question = Question.find(params[:id])
		@question.destroy
		redirect_to questions_path
	end

private
	def question_params
		params.require(:question).permit(:title, :body)
	end

	def verify_access
	  @question = Question.find(params[:id])
		unless user_signed_in? && @question.user_id == current_user.id
      flash[:error] = "Access Denied"
      redirect_to @question
    end
  end

end
