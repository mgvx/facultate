class AnswersController < ApplicationController
before_action :verify_access, only: [ :destroy]

  def create
    @question = Question.find(params[:question_id])
    if answer_params[:body] != ""
      @answer = @question.answers.create(answer_params)
  		@answer.update_attribute(:question_id, @question.id)
  		@answer.update_attribute(:user_id, current_user.id)
    else
      flash[:error] = "Void Comment"
    end
    redirect_to question_path(@question)
  end

  def destroy
    binding.pry
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end

private
  def answer_params
    params.require(:answer).permit(:body)
  end

	def verify_access
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
		unless user_signed_in? && @answer.user_id == current_user.id
      flash[:error] = "Access Denied"
      redirect_to @question
    end
  end
end
