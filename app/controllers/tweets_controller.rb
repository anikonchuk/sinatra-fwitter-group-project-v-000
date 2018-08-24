class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if current_user == tweet.user.id
      tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{tweet.id}"
    end
  end

  post '/tweets' do
    user = current_user
    tweet = Tweet.new(content: params[:content])
    if tweet.save
      user.tweets << tweet
      user.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

end
