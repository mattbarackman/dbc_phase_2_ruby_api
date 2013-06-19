get '/vimeo/authenticate' do
  base = vimeo_base
  request_token = base.get_request_token
  session[:oauth_secret] = request_token.secret
  base.authorize_url
  redirect base.authorize_url
end

get '/vimeo/redirect' do
  access_token = get_access_token
  user = current_user
  user.token = access_token.token
  user.secret = access_token.secret
  user.save
  redirect '/'
end

post '/user/videos' do
  user = params[:user]
  redirect "/#{user}/videos"
end

get '/:user/videos' do |user|
  @video_ids = user_videos(user)
  erb :videos
end

get '/mattbarackman/likes' do
  @video_ids = liked_videos
  erb :videos
end


post '/videos/tagged' do
  tag = params[:tag]
  redirect "/videos/tagged/#{tag}"
end

get '/videos/tagged/:tag' do |tag|
  @video_ids = tagged_videos(tag)
  erb :videos
end

