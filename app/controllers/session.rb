#----------- SESSIONS -----------

get '/sessions/new' do
  @errors = errors 
  erb :sign_in
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user.nil?
    session[:errors] = {username: "not found"}
    redirect '/sessions/new'
  elsif user.authenticate(params[:password]) == false
    session[:errors] = {password: "incorrect"}
    redirect '/sessions/new'    
  else
    session[:user_id] = user.id
    redirect '/'
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
end