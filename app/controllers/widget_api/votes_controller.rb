class WidgetApi::VotesController < WidgetController

  # POST / GET
  def cast
    # Early exit if voter is the creator of the idea..
    if widget_user.email == vote_receiver.creator.email
      return render json: { error: "You can't wote for your own idea" }, status: 403
    end
    vote_val = params[:value] || 0
    if vote_val == 0
      status
    elsif widget_user
      cast_vote(vote_val)
    else
      render json: { error: 'You need to be signed in to vote' }, status: 403
    end
  end

  private

  def status
    vote_receiver
    if widget_user
      vote
    else
      @vote = Vote.new
    end
  end

  def cast_vote(value)
    vote.cast_vote(value, current_application.id)
    vote_receiver.reload
  end

  def vote_receiver
    @vote_receiver ||= if params[:idea_id]
      current_application.ideas.find(params[:idea_id])
    elsif params[:comment_id]
      current_application.comments.find(params[:comment_id])
    else
      raise 'No vote receiver'
    end
  end

  def vote
    @vote ||= widget_user.votes.find_or_initialize_by(vote_receiver: vote_receiver)
  end
end
