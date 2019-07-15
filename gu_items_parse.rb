require_relative 'common'

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

urls = ["https://www.uniqlo.com/jp/gu/search/categories=men%252Fouter", "https://www.uniqlo.com/jp/gu/search/categories=men%252Ftops", "https://www.uniqlo.com/jp/gu/search/categories=men%252Fbottoms", "https://www.uniqlo.com/jp/gu/search/categories=men%252Finner", "https://www.uniqlo.com/jp/gu/search/categories=men%252Fshoes", "https://www.uniqlo.com/jp/gu/search/categories=men%252Fgoods"]
urls.each_with_index do |url, index|
  item_array = Gu_parse.new(url).main
  binding.pry
  item_array.each do |item|
    next if item[2]&.gsub(/¥/, "") == ""
    Items_alls.create(number: item[0]&.gsub(/.*：/, "").slice(/.{6}?/), name: item[1], selling_price: item[2]&.gsub(/¥|,/, ""),  url: item[3], img_url: item[4], category: "outer") if index == 0
    Items_alls.create(number: item[0]&.gsub(/.*：/, "").slice(/.{6}?/), name: item[1], selling_price: item[2]&.gsub(/¥|,/, ""),  url: item[3], img_url: item[4], category: "tops") if index == 1
    Items_alls.create(number: item[0]&.gsub(/.*：/, "").slice(/.{6}?/), name: item[1], selling_price: item[2]&.gsub(/¥|,/, ""),  url: item[3], img_url: item[4], category: "bottoms") if index == 2
    Items_alls.create(number: item[0]&.gsub(/.*：/, "").slice(/.{6}?/), name: item[1], selling_price: item[2]&.gsub(/¥|,/, ""),  url: item[3], img_url: item[4], category: "inner") if index == 3
    Items_alls.create(number: item[0]&.gsub(/.*：/, "").slice(/.{6}?/), name: item[1], selling_price: item[2]&.gsub(/¥|,/, ""),  url: item[3], img_url: item[4], category: "shoes") if index == 4
    Items_alls.create(number: item[0]&.gsub(/.*：/, "").slice(/.{6}?/), name: item[1], selling_price: item[2]&.gsub(/¥|,/, ""),  url: item[3], img_url: item[4], category: "goods") if index == 5
  end
end
