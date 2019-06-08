require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'mechanize'
require 'active_record'
require 'logger'

url1 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=314667&item_ids[]=312328&item_ids[]=312325&item_ids[]=312324&item_ids[]=312319&item_ids[]=312315&item_ids[]=312317&item_ids[]=312318&item_ids[]=312321&item_ids[]=312345&item_ids[]=312320&item_ids[]=312346&item_ids[]=312316&item_ids[]=303755&limit=14'


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
#class Items_shoes < ActiveRecord::Base;
#end

#item_array.each do |item|
#  Items_shoes.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
#end
#end

class Items_alls < ActiveRecord::Base;
end

item_array.each do |item|
  Items_alls.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
end
end
