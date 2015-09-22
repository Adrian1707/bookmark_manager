require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  # get '/' do
  #   'Hello BookmarkManager!'
  # end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new_link'
  end

  post '/links' do
    link = Link.first_or_create(title: params[:title], url: params[:url])
    tag = Tag.first_or_create(name: params[:tag])
    link.tags << tag
    link.save
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
