require 'sinatra'
require 'sinatra/reloader' if development?
require "sinatra/cookies"

get '/' do
    if params[:action] == 'set'
        if params[:name] and params[:value]
            cookies[params[:name]] = params[:value]
            halt 200, "Cookie created successfully"
        else
            halt 501, "Required get parameters missing: name and/or value parameters required"
        end
    end

    if params[:action] == 'del'
        if cookies.key? params[:name]
            cookies.delete(params[:name])
            halt 200, "Successfully Deleted #{params[:name]} cookie"
        else
            halt 404, "#{params[:name]} not found in cookie"
        end
    end

    if params[:action] == 'get'
        if cookies.key? params[:name]
            halt 200, cookies[params[:name]]
        else
            halt 404, "#{params[:name]} not found in cookie"
        end
    end
end