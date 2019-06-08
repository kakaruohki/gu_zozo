require_relative 'zozo.rb'
require_relative 'mecab.rb'
require 'active_record'
require 'logger'
require 'pry'

#pp Mecab.new("シャツ", "オックスフォードシャツ").calc_score

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'root',
  password: '',
  database: 'gu',
)
class Items_alls < ActiveRecord::Base;
end


#tops = Items_tops.all
#pp tops
n = 1
Zozo.new.rank.each do |zozo_item|
  Items_alls.pluck(:name).each do |gu_item|
    pp [zozo_item,gu_item,Mecab.new(zozo_item, gu_item).calc_score] if !(Mecab.new(zozo_item, gu_item).calc_score == 0)
  end
  n += 1
  if n == 50
    break
  end
end
