require 'minitest/autorun'
require './zozo'
require 'pry'

class GuTest < Minitest::Unit::TestCase
  def test_judge
    item_array = Zozo.new.rank
    assert_equal "浴衣 メンズ 5点 セット【 浴衣＋帯＋下駄＋扇子＋信玄袋 】", item_array[0] #7月17日午前11時時点
    assert_equal "TRタックワイドパンツ テーパードスラックス", item_array[9] #7月17日午前11時時点
    assert_equal "POLO RALPHLAUREN ポロ ラルフローレン ワンポイントロゴ クラシックコットン クルーネック 半袖Tシャツ  ボーイズライン", item_array[19] #7月17日午前11時時点
    assert_equal "スウェットパンツ ジョガーパンツ ラインパンツ イージーパンツ トラックパンツ", item_array[29] #7月17日午前11時時点
    assert_equal "WEB限定 KANGOL×FREAK'S STORE/カンゴール 別注ビッグシルエット バックプリント半袖ヘビーウェイトTシャツ/オーバーサイズカットソー", item_array[39] #7月17日午前11時時点
    assert_equal "TRストレッチテーパードスラックス", item_array[49] #7月17日午前11時時点

  end
end
