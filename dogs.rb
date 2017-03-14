require 'csv'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

# configure :development, :test do
#   require 'pry'
# end

get '/' do
  redirect '/dogs'
end

get '/dogs' do
  @dogs = CSV.readlines('dogs.csv', headers: true) #first line, ignore it. it wont show up on on our page.
  erb :index
end

post '/dogs' do
  # @dogs = []
  breed = params[:breed]
  photo = params[:photo]

  if !breed.empty? && !photo.empty?
    CSV.open('dogs.csv', 'a', headers: true) do |file|
    # entry = "#{breed, photo}"
      file << [breed, photo]
    end
  end

  redirect '/'
end
