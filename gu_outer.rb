require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'mechanize'
require 'active_record'
require 'logger'

url1 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=314034&item_ids[]=314907&item_ids[]=314027&item_ids[]=314022&item_ids[]=314002&item_ids[]=313998&item_ids[]=313997&item_ids[]=314033&item_ids[]=314019&item_ids[]=314021&item_ids[]=314003&item_ids[]=313996&item_ids[]=314024&item_ids[]=314018&item_ids[]=314000&item_ids[]=315517&item_ids[]=314026&item_ids[]=314015&item_ids[]=314029&item_ids[]=314037&item_ids[]=314032&item_ids[]=314028&item_ids[]=31399500001&item_ids[]=313995&item_ids[]=307702&item_ids[]=306918&item_ids[]=289743&limit=27'

urls = [url1]

urls.each do |url|
charset = nil
sleep(1)
html = open(url) do |f|
    charset = f.charset
    f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)
items = JSON.parse(doc.text)["items"]
item_array = []
items.each do |item|
  item_array << [item["id"], item["name"].gsub(/（GU）/, ''), item["selling_price"], item["original_price"]]
end

#binding.pry
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'root',
  password: '',
  database: 'gu',
)
#class Items_outers < ActiveRecord::Base;
#end

#item_array.each do |item|
#  Items_outers.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
#end
#end

class Items_alls < ActiveRecord::Base;
end

item_array.each do |item|
  Items_alls.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
end
end
