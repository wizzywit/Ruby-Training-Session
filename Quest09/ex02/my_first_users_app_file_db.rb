require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require '../../Quest08/ex03/my_user_class.rb'
require "sinatra/cookies"

# enable sessions
enable :sessions

# Instantiate the user class
$instance_user = User.new

# post endpoint to create a new user and store in database
post '/users' do
    # retrieve the payload from client, convert to hash then retrive all the values
    data = request.body.read
    user_data = JSON.parse(data).values

    # Create new user and store in database
    value = $instance_user.create user_data

    # return statement if successful
    if value > 0
        halt 200, {:status=>200, :message=>"User created successfully"}.to_json
    end
    halt 400, "Unable to create user"
end

# get endpoint to retrive all the users in the database without password
get '/users' do

    #retrive all users in the database
    users = $instance_user.all

    # respond with no record in database if database is empty
    if users.key? :status
        halt users[:status], users.to_json
    end

    # map throught all the retrived users and remove all their password information
    output_users = users.map do |key,user|
        new_hash = Hash.new
        user.each do |k,v|
            k == "password"? next : new_hash[k] = v
        end
        [key, user=new_hash]
    end

    # respond with all users information without password information
    halt 200, output_users.to_h.to_json
end

# post endpoint to sign in a user stored in database
post '/sign_in' do
    #retrive all users
    users = $instance_user.all

    # read payload data and convert to hash
    data = request.body.read
    login_data = JSON.parse(data)

    # initialize loggedIn to false
    loggedIn = false

    # loop through every user and compare login data with the user data
    # e.g email == email, and store user ID into the session variable user_id
    users.each do |key,value|
        if value["email"] == login_data["email"] and value["password"] == login_data["password"]
            session[:user_id] = key
            loggedIn = true
        else
            next
        end
    end

    # checked the boolean value of loggedIn and respond with the appriopraite message
    if loggedIn
        halt 200, {:status=>200, :message=>"Successfully logged in", :session_id => session[:user_id]}.to_json
    else
        session.delete(:user_id)
        halt 401, {:status=>401, :message=>"Invalid Authentication: Invalid Email or Password"}.to_json
    end
end

# put endpoint to update a signed in user password
put '/users' do
    # exit from endpoint if user is not loggedIn, that is no session variable user_id stored
    unless session[:user_id]
        halt 401, {:status=>401, :message=>"Unathorized: Login/Signin to have access to this route"}.to_json
    end

    #retrive payload data for update and convert to hash
    data = request.body.read
    password = JSON.parse(data)

    # retrieve a particular user, passing the user session id
    user_info = $instance_user.get(session[:user_id].to_i)

    # check the old password payload with the retrieved user password
    # if check passes then update that users password and respond with that user new updated info
    if password["oldpassword"] == user_info["password"]
        user_info = $instance_user.update(session[:user_id].to_i,"password",password["new_password"])
        halt 200, {:status=>200, :data=>user_info}.to_json
    else
        halt 403, {:status=>403, :message=>"Old Password Mismatch"}.to_json
    end
end

# delete endpoint to signout a user that must be signed in, by unsetting/deleting the session user_id
delete '/sign_out' do

    # exit from endpoint if user is not loggedIn, that is no session variable user_id stored
    unless session[:user_id]
        halt 401, {:status=>401, :message=>"Unathorized: Login/Signin to have access to this route"}.to_json
    end

    # delete user session
    session.delete(:user_id)

    # respond in json form the success message
    halt 200, {:status=>200, :message=>"Logged out Successfully"}.to_json
end

# delete endpoint to signout and destroy a user from database
delete '/users' do
    # exit from endpoint if user is not loggedIn, that is no session variable user_id stored
    unless session[:user_id]
        halt 401, {:status=>401, :message=>"Unathorized: Login/Signin to have access to this route"}.to_json
    end

    # destroy a loggedIn user by passing in the session user_id
    message = $instance_user.destroy(session[:user_id].to_i)

    # delete user session
    session.delete(:user_id)

    # respond in json form the success message
    halt 200, {:status=>200, :message=>message[:message]}.to_json
end
