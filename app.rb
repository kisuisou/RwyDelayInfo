require 'sinatra'
require './readDB'

get '/' do
@infoArray = returnInfo()
erb :index
end
