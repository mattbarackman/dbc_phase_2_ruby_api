helpers do

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def errors
    session.delete(:errors) if session[:errors]
  end

  def convert_for_session(form_data)
    data = {}
    form_data.each do |key, value|
      data[key.to_sym] = value
    end
    data
  end

end
