require 'sinatra'
require 'sinatra/reloader'

enable :sessions

before do
  @income = session['income'] || 0
end

get '/' do
  @needs = (@income * 0.5) || 0
  @wants =  (@income * 0.3) || 0
  @savings = (@income * 0.2) || 0
  erb :main
end

post '/income' do
  session['income'] = params['income'].to_i
  redirect '/'
end

# session {key: value}
# {income: input}