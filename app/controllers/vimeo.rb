get '/vimeo/authenticate' do
  User.create()
  base = Vimeo::Advanced::Base.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
  request_token = base.get_request_token
  session[:oauth_secret] = request_token.secret
  base.authorize_url
  redirect base.authorize_url
end

get '/vimeo/redirect' do
  base = Vimeo::Advanced::Base.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
  access_token = base.get_access_token(params["oauth_token"], session["oauth_secret"], params[:oauth_verifier])
  # You'll want to hold on to the user's access token and secret. I'll save it to the database.
  user = current_user
  user.token = access_token.token
  user.secret = access_token.secret
  user.save
  redirect '/'
end

get '/enginecompanyone/videos' do
  video = Vimeo::Advanced::Video.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], :token => current_user.token, :secret => current_user.secret)
  ec1_videos = video.get_all("enginecompany1")["videos"]["video"][0..4]
  @video_ids = ec1_videos.map {|video| video["id"]}
  erb :videos
end

get '/mattbarackman/likes' do
  video = Vimeo::Advanced::Video.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], :token => current_user.token, :secret => current_user.secret)
  matts_videos = video.get_likes("16214708", { :page => "1", :per_page => "5", :full_response => "0", :sort => "most_liked" })["videos"]["video"][0..4]
  p @video_ids = matts_videos.map {|video| video["id"]}
  erb :videos
end

get '/dubstep/videos' do
  video = Vimeo::Advanced::Video.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], :token => current_user.token, :secret => current_user.secret)
  dubstep_videos = video.get_by_tag("dubstep", { :page => "1", :per_page => "5", :full_response => "0", :sort => "most_liked" })["videos"]["video"][0..4]
  @video_ids = dubstep_videos.map {|video| video["id"]}
  erb :videos
end
