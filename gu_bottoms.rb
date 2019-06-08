require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'mechanize'
require 'active_record'
require 'logger'

url1 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=317105&item_ids[]=316588&item_ids[]=316223&item_ids[]=314938&item_ids[]=314934&item_ids[]=314933&item_ids[]=314759&item_ids[]=316001&item_ids[]=316000&item_ids[]=314456&item_ids[]=314455&item_ids[]=314454&item_ids[]=315752&item_ids[]=314451&item_ids[]=314449&item_ids[]=314943&item_ids[]=314942&item_ids[]=314448&item_ids[]=314453&item_ids[]=316974&item_ids[]=316973&item_ids[]=316972&item_ids[]=314541&item_ids[]=316597&item_ids[]=314944&item_ids[]=314941&item_ids[]=314936&item_ids[]=314935&item_ids[]=316239&item_ids[]=316236&item_ids[]=315751&item_ids[]=314940&item_ids[]=314569&item_ids[]=314547&item_ids[]=314542&item_ids[]=314450&item_ids[]=316237&item_ids[]=316222&item_ids[]=314458&item_ids[]=314441&item_ids[]=314435&item_ids[]=306570&item_ids[]=315117&item_ids[]=315118&item_ids[]=316687&item_ids[]=315116&item_ids[]=314443&item_ids[]=315475&item_ids[]=317309&item_ids[]=317284&item_ids[]=315788&item_ids[]=315114&item_ids[]=314437&item_ids[]=315476&item_ids[]=315115&item_ids[]=314439&item_ids[]=316638&item_ids[]=315474&item_ids[]=31444200001&item_ids[]=314442&limit=60'
url2 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=316798&item_ids[]=314920&item_ids[]=314560&item_ids[]=314546&item_ids[]=314545&item_ids[]=31454300001&item_ids[]=314543&item_ids[]=314540&item_ids[]=314446&item_ids[]=314438&item_ids[]=314436&item_ids[]=314828&item_ids[]=314447&item_ids[]=314440&item_ids[]=314434&item_ids[]=307537&item_ids[]=306573&item_ids[]=306571&item_ids[]=306676&item_ids[]=309657&item_ids[]=306569&item_ids[]=307434&item_ids[]=307119&item_ids[]=302341&item_ids[]=306572&item_ids[]=306568&item_ids[]=307827&item_ids[]=307817&item_ids[]=302344&item_ids[]=301947&item_ids[]=302590&item_ids[]=300545&item_ids[]=298119&item_ids[]=298116&item_ids[]=298114&item_ids[]=298115&item_ids[]=289444&limit=37'

urls = [url1, url2]

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
#class Items_bottoms < ActiveRecord::Base;
#end

#item_array.each do |item|
#  Items_bottoms.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
#end
#end

class Items_alls < ActiveRecord::Base;
end

item_array.each do |item|
  Items_alls.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
end
end
