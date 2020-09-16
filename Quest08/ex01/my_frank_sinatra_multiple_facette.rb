require "sinatra"
require 'sinatra/reloader' if development?

set :port, 8080
frank_sinatra_songs = [
    "Accidents Will Happen",
    "Ain't She Sweet",
    "Before the Music Ends",
    "Begin the Beguine",
    "The Best is Yet to Come",
    "Between the Devil and the Deep Blue Sea",
    "Bewitched, Bothered and Bewildered",
    "Call Me Irresponsible",
    "Collegiate",
    "The Day After Forever",
    "Day by Day",
    "Dear Heart",
    "Dick Haymes, Dick Todd and Como",
    "Early American",
    "Elizabeth",
    "Empty Is (spoken)",
    "Empty Tables",
    "Faithful",
    "Farewell, Farewell to Love",
    "Feet of Clay",
]

get '/' do
    "<h1><center>#{frank_sinatra_songs.sample}</center></h1>"
end

get '/birth_date' do
    birth_date = "December 12, 1915"
    "<h1><center>Frank Sinatra Birth Date: #{birth_date}</center></h1>"
end

get '/birth_city' do
    birth_city = "Hoboken, New Jersey, U.S."
    "<h1><center>Frank Sinatra Birth City: #{birth_city}</center></h1>"
end

get '/wifes' do
    formatted_wifes = ""
    wifes = [
        "Nancy Barbato",
        "Ava Gardner",
        "Mia Farrow",
        "Barbara Marx"
    ]
    wifes.each_with_index do |wife,index|
        if (index+1) == wifes.size()
            formatted_wifes += wife
        else
            formatted_wifes += wife+", "
        end
    end
    "<h1><center>#{formatted_wifes}</center></h1>"
end

get '/picture' do 
    erb(:image)
end

__END__
@@ layout
<html>
  <head>
    <title> Frank Sinatra Backend Application</title>
    <meta charset="utf-8" />
  </head>
  <body><%= yield %></body>
</html>

@@ image 
<div> 
  <img src="https://upload.wikimedia.org/wikipedia/commons/a/af/Frank_Sinatra_%2757.jpg" /> 
<div>