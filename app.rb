require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require 'active_record'

require_relative 'db/connection'
require_relative 'models/artist'
require_relative 'models/song'

get '/' do
	erb :"home/index"
end

get '/artists' do
	@artists = Artist.all
	erb :"artists/index"
end

get '/artist/new' do
	erb :"artists/new"
end

get '/artist/:id/edit' do
	@artist = Artist.find(params[:id]);
	erb :"artists/edit"
end

get '/artist/:id' do
	@artist = Artist.find(params[:id])
	@songs = Song.where(artist_id: params[:id])
	erb :"artists/show"
end

post '/artist' do
	if params[:artist]["photo_url"] == ""
		params[:artist]["photo_url"] = "https://s.discogs.com/images/default-release-cd.png"
	end
	new_artist = Artist.create(params[:artist])
	redirect "/artist/#{ new_artist.id }"
end

put '/artist/:id' do
	artist = Artist.find(params[:id])
	artist.update(params[:artist])
	redirect "/artist/#{ artist.id }"
end

delete '/artist/:id' do
	artist = Artist.find(params[:id])
	artist.destroy
	redirect "/artists"
end











