require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'mechanize'
require 'active_record'
require 'logger'

url1 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=317110&item_ids[]=317038&item_ids[]=317034&item_ids[]=315479&item_ids[]=315024&item_ids[]=319405&item_ids[]=319361&item_ids[]=316900&item_ids[]=316022&item_ids[]=316021&item_ids[]=316017&item_ids[]=315999&item_ids[]=314650&item_ids[]=314383&item_ids[]=317714&item_ids[]=317713&item_ids[]=317712&item_ids[]=317711&item_ids[]=317710&item_ids[]=317709&item_ids[]=317708&item_ids[]=314523&item_ids[]=317146&item_ids[]=319830&item_ids[]=317361&item_ids[]=317360&item_ids[]=317359&item_ids[]=317358&item_ids[]=317357&item_ids[]=317356&item_ids[]=317355&item_ids[]=314525&item_ids[]=317029&item_ids[]=317028&item_ids[]=317027&item_ids[]=317026&item_ids[]=317025&item_ids[]=317024&item_ids[]=317023&item_ids[]=317022&item_ids[]=315831&item_ids[]=314502&item_ids[]=314386&item_ids[]=318270&item_ids[]=318269&item_ids[]=318268&item_ids[]=318239&item_ids[]=315834&item_ids[]=315833&item_ids[]=315828&item_ids[]=315754&item_ids[]=315753&item_ids[]=314717&item_ids[]=314528&item_ids[]=314515&item_ids[]=316943&item_ids[]=314380&item_ids[]=314860&item_ids[]=314535&item_ids[]=314382&limit=60'
url2 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=315659&item_ids[]=315657&item_ids[]=314648&item_ids[]=314378&item_ids[]=314377&item_ids[]=317252&item_ids[]=317251&item_ids[]=317250&item_ids[]=317249&item_ids[]=316783&item_ids[]=316782&item_ids[]=316781&item_ids[]=316780&item_ids[]=316779&item_ids[]=316778&item_ids[]=316777&item_ids[]=315315&item_ids[]=314949&item_ids[]=314527&item_ids[]=314524&item_ids[]=314379&item_ids[]=315658&item_ids[]=314928&item_ids[]=314924&item_ids[]=314912&item_ids[]=314514&item_ids[]=314509&item_ids[]=314501&item_ids[]=316197&item_ids[]=316196&item_ids[]=316195&item_ids[]=316194&item_ids[]=316193&item_ids[]=316192&item_ids[]=316191&item_ids[]=314518&item_ids[]=316002&item_ids[]=315830&item_ids[]=315829&item_ids[]=315827&item_ids[]=315421&item_ids[]=315419&item_ids[]=314513&item_ids[]=314506&item_ids[]=314505&item_ids[]=314504&item_ids[]=314498&item_ids[]=312659&item_ids[]=311403&item_ids[]=316940&item_ids[]=315832&item_ids[]=314646&item_ids[]=314500&item_ids[]=314499&item_ids[]=314374&item_ids[]=314373&item_ids[]=311400&item_ids[]=311399&item_ids[]=316799&item_ids[]=316784&limit=60'
url3 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=316053&item_ids[]=316052&item_ids[]=316051&item_ids[]=316042&item_ids[]=316804&item_ids[]=316803&item_ids[]=316802&item_ids[]=316801&item_ids[]=316800&item_ids[]=314519&item_ids[]=316050&item_ids[]=316049&item_ids[]=316048&item_ids[]=316041&item_ids[]=314960&item_ids[]=316038&item_ids[]=316037&item_ids[]=316036&item_ids[]=314516&item_ids[]=312658&item_ids[]=314376&item_ids[]=314366&item_ids[]=316047&item_ids[]=316046&item_ids[]=316045&item_ids[]=316040&item_ids[]=315308&item_ids[]=314915&item_ids[]=314914&item_ids[]=313561&item_ids[]=316880&item_ids[]=316628&item_ids[]=315709&item_ids[]=31547800001&item_ids[]=315478&item_ids[]=314642&item_ids[]=314640&item_ids[]=314365&item_ids[]=314364&item_ids[]=314363&item_ids[]=314362&item_ids[]=314361&item_ids[]=31436000001&item_ids[]=314360&item_ids[]=314359&item_ids[]=31435800001&item_ids[]=314358&item_ids[]=314919&item_ids[]=314512&item_ids[]=314511&item_ids[]=314507&item_ids[]=31449400001&item_ids[]=314494&item_ids[]=312962&item_ids[]=314489&item_ids[]=314488&item_ids[]=311037&item_ids[]=310088&item_ids[]=308909&item_ids[]=306671&limit=60'
url4 = 'https://catalog.gu-global.com/api/v1/jp/items?include_out_of_stock=true&item_ids[]=309635&item_ids[]=308908&item_ids[]=304410&item_ids[]=304168&item_ids[]=307837&item_ids[]=299575&item_ids[]=29957400001&item_ids[]=299574&item_ids[]=308669&item_ids[]=308668&item_ids[]=307998&item_ids[]=308507&item_ids[]=308897&item_ids[]=303407&item_ids[]=301638&item_ids[]=303619&item_ids[]=302335&item_ids[]=302323&item_ids[]=302319&item_ids[]=300633&item_ids[]=303518&item_ids[]=302337&item_ids[]=300533&item_ids[]=299573&item_ids[]=298892&item_ids[]=299579&item_ids[]=301114&item_ids[]=298896&limit=28'
urls = [url1, url2, url3, url4]

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
#class Items_tops < ActiveRecord::Base;
#end

#item_array.each do |item|
#  Items_tops.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
#end
#end

class Items_alls < ActiveRecord::Base;
end

item_array.each do |item|
  Items_alls.create(number: item[0].slice(/.{6}?/), name: item[1], selling_price: item[2], original_price: item[3], url: "https://www.uniqlo.com/jp/gu/item/" + "#{item[0].slice(/.{6}?/)}")
end
end
