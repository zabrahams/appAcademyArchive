class NotesController < ApplicationController

  before_action :require_login

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      flash[:notice] = "Note Added"
    else
      flash[:errors] = @note.errors.full_messages
    end
    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user_id == current_user.id
      flash[:notice] = "Note Deleted"
      @track = @note.track
      @note.destroy
      redirect_to track_url(@track)
    else
      render test: "You don't have permission to delete that note", status: 403
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end

end
