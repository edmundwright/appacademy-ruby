class NotesController < ApplicationController
  def create
    note = Note.new(note_params.merge({user_id: current_user.id}))

    if note.save
      flash[:notice] = "Thanks for adding a new note!"
    else
      flash.now[:errors] = @note.errors.full_messages
    end

    redirect_to track_url(note.track)
  end

  def destroy
    note = Note.find(params[:id])
    if note.user == current_user
      note.destroy!
      redirect_to track_url(note.track)
    else
      render text: "NOOOOOO"
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end
end
