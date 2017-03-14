require 'csv'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'  

configure :development, :test do
  require 'pry'
end

get '/' do
  @articles = CSV.read('articles.csv')
  erb :index
end

get '/articles/new' do
  erb :submission_form
end

post '/articles/new' do
  article_details = params.values

  CSV.open('articles.csv', 'a') do |file|
    file << article_details
  end

  redirect '/articles'
end

get '/articles' do
  @articles = CSV.read('articles.csv')

  erb :index
end
