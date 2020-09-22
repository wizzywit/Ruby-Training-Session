require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require '../../Quest08/ex03/my_user_class.rb'
require "sinatra/cookies"


enable :sessions

$instance_user = User.new
post '/users' do
    data = request.body.read
    user_data = JSON.parse(data).values
    value = $instance_user.create user_data
    if value > 0
        halt 200, {:status=>200, :message=>"User created successfully"}.to_json
    end
    halt 400, "Unable to create user"
end

get '/users' do
    users = $instance_user.all
    if users.key? :status
        halt users[:status], users.to_json
    end
    output_users = users.map do |key,user|
        new_hash = Hash.new
        user.each do |k,v|
            k == "password"? next : new_hash[k] = v
        end
        [key, user=new_hash]
    end
    halt 200, output_users.to_h.to_json
end

post '/sign_in' do
    users = $instance_user.all
    data = request.body.read
    login_data = JSON.parse(data)
    loggedIn = false
    users.each do |key,value|
        if value["email"] == login_data["email"] and value["password"] == login_data["password"]
            session[:user_id] = key
            loggedIn = true
        else
            next
        end
    end

    if loggedIn
        halt 200, {:status=>200, :message=>"Successfully logged in", :session_id => session[:user_id]}.to_json
    else
        session.delete(:user_id)
        halt 401, {:status=>401, :message=>"Invalid Authentication: Invalid Email or Password"}.to_json
    end
end

put '/users' do
    unless session[:user_id]
        halt 401, {:status=>401, :message=>"Unathorized: Login/Signin to have access to this route"}.to_json
    end
    data = request.body.read
    password = JSON.parse(data)
    user_info = $instance_user.get(session[:user_id].to_i)
    if password["oldpassword"] == user_info["password"]
        user_info = $instance_user.update(session[:user_id].to_i,"password",password["new_password"])
        halt 200, {:status=>200, :data=>user_info}.to_json
    else
        halt 403, {:status=>403, :message=>"Old Password Mismatch"}.to_json
    end
end

delete '/sign_out' do
    unless session[:user_id]
        halt 401, {:status=>401, :message=>"Unathorized: Login/Signin to have access to this route"}.to_json
    end
    session.delete(:user_id)
    halt 200, {:status=>200, :message=>"Logged out Successfully"}.to_json
end

delete '/users' do
    unless session[:user_id]
        halt 401, {:status=>401, :message=>"Unathorized: Login/Signin to have access to this route"}.to_json
    end
    message = $instance_user.destroy(session[:user_id].to_i)
    session.delete(:user_id)
    halt 200, {:status=>200, :message=>message[:message]}.to_json
end
