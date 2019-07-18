require_relative 'zozo'
require_relative 'mecab'
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

class Zozo_gu_items < ActiveRecord::Base;
end


#tops = Items_tops.all
#pp tops
n = 1
Zozo.new.rank.each_with_index do |zozo_item, rank|
  Items_alls.pluck(:name, :selling_price, :img_url, :url, :category).each do |gu_item|
    score = Mecab.new(zozo_item, gu_item[0]).calc_score
    Zozo_gu_items.create(zozo_item: zozo_item, zozo_rank: rank+1, gu_item: gu_item[0], gu_img_url: gu_item[2], gu_url: gu_item[3], category: gu_item[4], score: score) if score > 0.3
  end
  n += 1
  break if n == 50

end
