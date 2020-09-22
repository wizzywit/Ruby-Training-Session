require 'sinatra'
require 'sinatra/reloader' if development?

enable :sessions

get '/' do
    if params[:action] == 'set'
        if params[:name] and params[:value]
            session[params[:name]] = params[:value]
            halt 201, "Session cookie created successfully"
        else
            halt 501, "Required get parameters missing: name and/or value parameters required"
        end
    end

    if params[:action] == 'del'
        if session.key? params[:name]
            session.delete(params[:name])
            halt 200, "Successfully Deleted #{params[:name]} session"
        else
            halt 404, "#{params[:name]} not found in session"
        end
    end

    if params[:action] == 'get'
        if session.key? params[:name]
            halt 200, session[params[:name]]
        else
            halt 404, "#{params[:name]} not found in session"
        end
    end

    halt 501, "Invalid/Bad Request"
end