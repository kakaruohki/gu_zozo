require 'minitest/autorun'
require './common'
require 'pry'

class GuTest < Minitest::Unit::TestCase
  def test_judge
    url = "https://www.uniqlo.com/jp/gu/search/categories=men%252Fouter"
    item_array = Gu_parse.new(url).main
    assert_equal '商品番号：319913', item_array[0][0] #7月17日時点
    assert_equal 'ライトポケッタブルパーカGS', item_array[0][1]
    assert_equal '¥1,990', item_array[0][2]
    assert_equal 'https://www.uniqlo.com/jp/gu/item/319913', item_array[0][3]
    assert_equal 'https://im.uniqlo.com/images/jp/sp/goods/319913/item/58_319913_mb.jpg', item_array[0][4]

    assert_equal '商品番号：314003', item_array[10][0] #7月17日時点
    assert_equal 'ウィンドプルーフシェルパーカ', item_array[10][1]
    assert_equal '¥1,990', item_array[10][2]
    assert_equal 'https://www.uniqlo.com/jp/gu/item/314003', item_array[10][3]
    assert_equal 'https://im.uniqlo.com/images/jp/sp/goods/314003/item/68_314003_mb.jpg', item_array[10][4]
  end
end
