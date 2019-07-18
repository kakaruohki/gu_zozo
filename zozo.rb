require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'mechanize'
class Zozo
def initialize
  super
end
def rank
url = 'https://zozo.jp/ranking/json/top_goodsranking_men.txt'

charset = nil
sleep(1)
html = open(url) do |f|
    charset = f.charset
    f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)

items = JSON.parse(doc.text)["data"]["ranking"]
#doc_arrays = []
#item_array = []
name_array = []
items.each do |item|
  #binding.pry
  item_url = "https://zozo.jp" + item["link"]
  agent = Mechanize.new
  item_page = agent.get(item_url)
  item_html = item_page.body.toutf8
  #@item_name = item_doc.css('#item-intro h1').text
  #@item_status = item_doc&.css('.stock')
  item_doc = Nokogiri::HTML.parse(item_html, nil, charset)
  item_name = item_doc.css('#item-intro h1').text
  #binding.pry
  #doc_arrays << item_doc.css('.cartBlock.clearfix dl.clearfix')
  name_array << item_name
end
return name_array

end
end
