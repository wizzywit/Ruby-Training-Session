require 'sinatra'
require 'sinatra/reloader' if development?


get '/protected' do
    unless (params['username'] == 'admin') and (params['password'] == 'admin')
        halt 401, "Not authorized"
    end
    "Welcome, authenticated client"
end

get '/' do
    "Everybody can see this page"
end