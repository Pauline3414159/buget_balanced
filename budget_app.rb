require 'sinatra'
require 'sinatra/reloader'

enable :sessions

before do
  @income = session['income'] || 0
  @needs_hash = session['needs_hash'] || {}
  @wants_hash = session['wants_hash'] || {}
  @savings_hash = session['savings_hash'] || {}
end

get '/' do
  @needs = (@income * 0.5)
  @wants = (@income * 0.3)
  @savings = (@income * 0.2)
  @needs_values_total = @needs_hash.values.sum
  @wants_values_total = @wants_hash.values.sum
  @savings_values_total = @savings_hash.values.sum
  erb :main
end

get '/home' do
  redirect '/'
end

get '/why' do
  erb :why
end

get '/how' do
  erb :how
end

get '/about' do
  erb :about
end

get '/credits' do
  erb :credit
end

post '/income' do
  session['income'] = params['income'].to_i
  redirect '/'
end

# Adding to the needs:
post '/new_needs' do
  session['needs_hash'] = {} if session.key?('needs_hash') == false
  session['needs_hash'][params['new_category']] = params['new_amount'].to_i
  redirect '/'
end

# Adding to the wants:
post '/new_wants' do
  session['wants_hash'] = {} if session.key?('wants_hash') == false
  session['wants_hash'][params['new_category']] = params['new_amount'].to_i
  redirect '/'
end

# Adding to the savings:
post '/new_savings' do
  session['savings_hash'] = {} if session.key?('savings_hash') == false
  session['savings_hash'][params['new_category']] = params['new_amount'].to_i
  redirect '/'
end

# Editing needs:
post '/edit_needs/:category' do
  session['needs_hash'][params['category']] = params['new_val'].to_i
  redirect '/'
end

# Editing wants:
post '/edit_wants/:category' do
  session['wants_hash'][params['category']] = params['new_val'].to_i
  redirect '/'
end

# Editing needs:
post '/edit_savings/:category' do
  session['savings_hash'][params['category']] = params['new_val'].to_i
  redirect '/'
end

# Deleting from needs:
post '/delete_needs' do
  session['needs_hash'].delete(params['category'])
  redirect '/'
end

# Deleting from wants:
post '/delete_wants' do
  session['wants_hash'].delete(params['category'])
  redirect '/'
end

# Deleting from savings:
post '/delete_savings' do
  session['savings_hash'].delete(params['category'])
  redirect '/'
end
