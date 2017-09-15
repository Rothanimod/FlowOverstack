class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

 # GET /comments
 # GET /comments.json
 def index
   @comments = Comment.all
 end

 # GET /comments/1
 # GET /comments/1.json
 def show
 end

 # GET /comments/new
 def new
   @comment = Comment.new
 end

 # GET /comments/1/edit
 def edit
 end

 # POST /comments
 # POST /comments.json
 def create
   #TODO - FLAG to differentiate creating a comment for a question and comment for an answer
   #
   if params[:comment][:fraggu].present?
     @answer = Answer.find(params[:comment][:answer_id])
     @comment = @answer.comments.create(comment_params)
   else
     @question = Question.find(params[:comment][:question_id])
     @comment = @question.comments.create(comment_params)
   end
   @comment.user = current_user
   respond_to do |format|
     if @comment.save
       #try redirecting to @comment.question
       format.html { redirect_to question_path(id: params[:comment][:question_id]), notice: 'Comentario publicado satisfactoriamente' }
       format.json { render :show, status: :created, location: @question }
     else
       format.html { redirect_to question_path(id: params[:comment][:question_id]), notice: 'El campo comentario no puede estar vacio'}
       format.json { render json: @comment.errors, status: :unprocessable_entity }
     end
   end
   #  redirect_to post_path(id: @comment.post_id)
   #  redirect_to (:back), :notice => "problem with the start_date and end_date" and return
 end

 # PATCH/PUT /comments/1
 # PATCH/PUT /comments/1.json
 def update
   respond_to do |format|
     if @comment.update(comment_params)
       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
       format.json { render :show, status: :ok, location: @comment }
     else
       format.html { render :edit }
       format.json { render json: @comment.errors, status: :unprocessable_entity }
     end
   end
 end

 # DELETE /comments/1
 # DELETE /comments/1.json
 def destroy
   @comment.destroy
   respond_to do |format|
     format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
     format.json { head :no_content }
   end
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_comment
     @comment = Comment.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def comment_params
     params.require(:comment).permit(:content)
   end
end
