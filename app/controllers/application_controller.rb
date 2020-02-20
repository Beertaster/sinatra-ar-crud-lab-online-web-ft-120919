
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
    Article.create(params)
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params["id"])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params["id"])
    erb :edit
  end
  
  patch '/articles/:id' do
    id = params["id"]
    update_param = {}
    first_article = Article.find(id)
    update_param[:title] = params["title"]
    update_param[:content] = params["content"]
    first_article.update(update_param)

    redirect "/articles/#{id}"
  end
  
  delete '/articles/:id/delete' do
    @article = Article.find(params["id"])
    @article.destroy
    erb :delete
  end
end
