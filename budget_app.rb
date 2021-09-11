require 'sinatra'
require 'sinatra/reloader'

enable :sessions

before do
  @income = session['income'] || 0
  @needs_hash = session['needs_hash'] || {}
end

get '/' do
  @needs = (@income * 0.5)
  @wants =  (@income * 0.3)
  @savings = (@income * 0.2)
  @needs_values_total = @needs_hash.values.sum
  erb :main
end

post '/income' do
  session['income'] = params['income'].to_i
  redirect '/'
end

post '/new_needs' do
  if session.key?('needs_hash')
    session['needs_hash'][params['new_category']] = params['new_amount'].to_i
  else
    session['needs_hash'] = {}
    session['needs_hash'][params['new_category']] = params['new_amount'].to_i
  end
  redirect '/'
end

# session {needs_hash: {housing: 300, ... }}
# {income: input}