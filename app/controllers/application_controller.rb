
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

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  post '/articles' do
    article = Article.create
    article.title = params["title"]
    article.content = params["content"]
    article.save
    @articles = Article.all

    redirect("/articles/#{article.id}")
    #erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params["id"])
    @article.title = params["title"]
    @article.content = params["content"]
    @article.save

    erb :show
  end

  delete '/articles/:id' do
    article = Article.find(params["id"])
    article.destroy

    @articles = Article.all

    erb :index
  end
end