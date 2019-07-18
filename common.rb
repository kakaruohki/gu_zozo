require 'nokogiri'
require 'open-uri'
require 'pry'
require 'mechanize'
require 'active_record'
require 'logger'
require 'selenium-webdriver'

class Gu_parse
def initialize(url)
ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"
caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {args: ["--headless","--no-sandbox", "--disable-setuid-sandbox", "--disable-gpu", "--user-agent=#{ua}", 'window-size=1280x800']})
#caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {args: ["--user-agent=#{ua}", "window-size=1280x800"]})
client = Selenium::WebDriver::Remote::Http::Default.new
@driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: client
@driver.navigate.to url
#html = @driver.page_source
sleep(1)
end

def query_click(css_selector)
  javascript_statement = %Q{document.querySelector("#{css_selector}").click()}
  @driver.execute_script(javascript_statement)
  sleep(1)
  self
end

def main
html = @driver.page_source
doc = Nokogiri::HTML.parse(html, nil, 'utf-8')
item_array = []
page_num = doc.css("#root > div > main > div > div > div.flex.justify-space-between > div:nth-child(2) > div > div.flex.justify-flex-end > div > ul > li:nth-last-child(2)").text
loop do
  doc = Nokogiri::HTML.parse(@driver.page_source, nil, 'utf-8')
  items_selectors = doc.css("#root > div > main > div > div > div.flex.justify-space-between > div:nth-child(2) > div > div.flex.wrap > div")
  items_selectors.each do |item_selector|
    query_click(item_selector.css_path + " > div > a")
    html = @driver.page_source
    doc2 = Nokogiri::HTML.parse(html, nil, 'utf-8')
    name = doc2.css("#stickyTop > div:nth-child(1)").text
    number = doc2.css("#root > div > main > div > div > div:nth-child(1) > div.flex.justify-center > div:nth-child(1) > div:nth-last-child(2) > div > span:nth-child(2) > span").text
    selling_price = doc2.css("#stickyTop > div:nth-child(3) > span > span:nth-child(1)").text
    url = @driver.current_url
    img = "https:" + doc2.css("#root > div > main > div > div > div:nth-child(1) > div.flex.justify-center > div:nth-child(1) > div:nth-child(2) > div > div.slider > div.slider-frame > ul > li.slider-slide.slide-visible > div > div > div > img").attribute("src").text
    item_array << [number, name, selling_price, url, img]
    @driver.navigate.back
    sleep(1)
  end
  node = Nokogiri::HTML.parse(@driver.page_source, nil, 'utf-8')
  p "success!"
  break if node.css("li.pagination-active").text == page_num
  query_click("li.next > a ")
end
  item_array
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
class Items_alls < ActiveRecord::Base;
end
