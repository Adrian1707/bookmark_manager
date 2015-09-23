require 'sinatra/base'
require_relative './data_mapper_setup'

class BookmarkManager < Sinatra::Base
  set :views, proc {File.join(root,'..','/app/views')}

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
    link = Link.new(title: params[:title], url: params[:url])
    # tag = Tag.first_or_create(name: params[:tag])
    string_array = params[:tag].split(/\s+/)
    string_array.each do |word|
    tag = Tag.create(name: word)
    link.tags << tag
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
