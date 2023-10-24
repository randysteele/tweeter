class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :asc)
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.turbo_stream
      else
        format.html do 
          flash[:tweet_errors] = @tweet.errors.full_messages
          redirect_to root_path
        end
      end
      end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
  end

  def retweet
   @tweet = Tweet.find(params[:id])
   retweet = current_user.tweets.new(tweet_id: @tweet.id)

   respond_to do |format|
    if retweet.save
      format.turbo_stream
    else
      format.html { redirect_back fallback_location: @tweet, alert: "Could not retweet"}
    end
  end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :tweet_id)
  end
end