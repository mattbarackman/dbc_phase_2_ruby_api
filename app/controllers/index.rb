get '/' do
  User.create()
  base = Vimeo::Advanced::Base.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
  request_token = base.get_request_token
  session[:oauth_secret] = request_token.secret
  p base.authorize_url
  redirect base.authorize_url
end

get '/signedin' do
  p params
  base = Vimeo::Advanced::Base.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
  access_token = base.get_access_token(params["oauth_token"], session["oauth_secret"], params[:oauth_verifier])
  # You'll want to hold on to the user's access token and secret. I'll save it to the database.
  user = User.last
  user.token = access_token.token
  user.secret = access_token.secret
  user.save
end