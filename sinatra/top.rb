require 'sinatra'
require 'active_record'
require 'logger'

helpers do
  def html(text)
    Rack::Utils.escape_html(text)
  end
end

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'root',
  password: '',
  database: 'gu',
)

class Zozo_gu_items < ActiveRecord::Base;
end

get '/get_category' do
  erb :get_category
end

post '/result' do
  @category = params[:category]
  @items = Zozo_gu_items
  erb :result
end
