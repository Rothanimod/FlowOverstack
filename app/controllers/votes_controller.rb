class VotesController < ApplicationController
  # before_action :set_vote, only: [:destroy]
  def create

    if params[:fraggu].present?
      @answer = Answer.find(params[:answer_id])
      @vote = @answer.votes.create
    else
      @question = Question.find(params[:question_id])
      @vote = @question.votes.create
    end
    @vote.user = current_user
    respond_to do |format|
      if @vote.save
        #try redirecting to @comment.question
        format.html { redirect_to question_path(id: params[:question_id]), notice: 'Voto registrado satisfactoriamente' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { redirect_to question_path(id: params[:question_id]), notice: 'No se pudo registrar el voto' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    #  redirect_to post_path(id: @comment.post_id)
    #  redirect_to (:back), :notice => "problem with the start_date and end_date" and return
  end

  def destroy
    vt = Vote.where(user_id: params[:user_id], votable_type: params[:votable_type], votable_id: params[:votable_id])
    Vote.destroy(vt.ids)
    respond_to do |format|
      format.html { redirect_to question_path(id: params[:question_id]), notice: 'voto anulado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_vote
    #   @vote = Vote.find(params[:id])
    # end
end
