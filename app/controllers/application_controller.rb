
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end
  
  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    Post.create(params)
    redirect '/posts'
  end

  get '/articles' do
    @posts = Post.all
    erb :index
  end

  get '/articles/:id' do
    @post = Post.find(params["id"])
    erb :show
  end

  get '/articles/:id/edit' do
    @post = Post.find(params["id"])
    erb :edit
  end
  
  patch '/articles/:id' do
    id = params["id"]
    update_param = {}
    original_post = Post.find(id)
   update_param[:title] = params["title"]
    update_param[:content] = params["content"]
    original_post.update(update_param)

    redirect "/posts/#{id}"
  end
  
  delete '/articles/:id/delete' do
    @post = Post.find(params["id"])
    @post.destroy
    erb :delete
  end
end
