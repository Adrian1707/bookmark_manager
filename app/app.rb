require 'sinatra/base'
require 'sinatra/flash'
require_relative './data_mapper_setup'

class BookmarkManager < Sinatra::Base
  set :views, proc {File.join(root,'..','/app/views')}

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      User.get(session[:user_id])
    end
  end

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
    Tag.add_tags(params[:tag],link)
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
