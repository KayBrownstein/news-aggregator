require 'csv'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development, :test do
  require 'pry'
end

get '/' do
  # binding.pry
  @articles = CSV.read('articles.csv')
  # binding.pry
  erb :index
end

get '/articles/new' do
  erb :submission_form
end

post '/articles/new' do
  # erb :submission_form
  article_details = params.values
  # title = params[:title]
  # url = params[:url]
  # description = params[:description]

  CSV.open('articles.csv', 'a') do |file|
    # file << ('<strong>' + title + '</strong>: <a href="' + url + '" target="_blank">' + url + '</a> <br >' + description)
    file << article_details
  end

  redirect '/articles'
end

get '/articles' do
  @articles = CSV.read('articles.csv')

  # //WHY?

  erb :index
end
