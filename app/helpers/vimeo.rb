helpers do 

  def vimeo_base
    Vimeo::Advanced::Base.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
  end

  def get_access_token
    vimeo_base.get_access_token(params["oauth_token"], session["oauth_secret"], params[:oauth_verifier])
  end

  def liked_videos
    videos = vimeo_video.get_likes(vimeo_userid, { :page => "1", :per_page => "5", :full_response => "0", :sort => "most_liked" })["videos"]["video"]
    videos.map {|video| video["id"]}
  end

  def vimeo_person
    person = Vimeo::Advanced::Person.new(ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"], :token => current_user.token, :secret => current_user.secret)
  end

  def vimeo_video
    video = Vimeo::Advanced::Video.new(ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"], :token => current_user.token, :secret => current_user.secret)
  end

  def vimeo_userid
    username = vimeo_person.checkAccessToken["oauth"]["user"]["username"]
  end

  def tagged_videos(tag)
    videos = vimeo_video.get_by_tag(tag, { :page => "1", :per_page => "5", :full_response => "0", :sort => "most_liked" })["videos"]["video"]
    videos.map {|video| video["id"]}
  end

  def user_videos(user)
    videos = vimeo_video.get_all(user, { :page => "1", :per_page => "5", :full_response => "0", :sort => "most_liked" })["videos"]["video"]
    videos.map {|video| video["id"]}
  end
end