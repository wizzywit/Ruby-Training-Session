require "sinatra"
require 'sinatra/reloader' if development?


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