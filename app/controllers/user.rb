#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @form_data = session.delete(:form_data) if session[:form_data]
  @errors = errors 
  erb :sign_up
end

post '/users' do
  user = User.new(params[:user])
  if user.valid?
    user.save
    session[:user_id] = user.id
    redirect '/'
  else
    session[:errors] = user.errors
    session[:form_data] = convert_for_session(params[:user])
    redirect '/users/new'
  end
end
