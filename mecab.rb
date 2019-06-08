require 'mecab'
require 'matrix'

# コサイン類似度を計算
# @param [String] str1 文字列
# @param [String] str2 文字列
# @return [Float] スコア
#str1 = 'オックスフォードシャツ'
#str2 = 'シャツ'
class Mecab
  def initialize(str1, str2)
    @str1 = str1
    @str2 = str2
  end
def calc_score
  vector = []
  vector1 = []
  vector2 = []
  frag_vector1 = []
  frag_vector2 = []

  node1 = MeCab::Tagger.new.parseToNode(@str1)
  node2 = MeCab::Tagger.new.parseToNode(@str2)

  while node1
    vector1.push(node1.surface)
    node1 = node1.next
  end

  while node2
    vector2.push(node2.surface)
    node2 = node2.next
  end

  vector += vector1
  vector += vector2

  #重複と空文字列を削除
  vector.uniq!.delete("")
  vector1.delete("")
  vector.delete("")
  vector2.delete("")

  vector.each do |word|
    if vector1.include?(word) then
      frag_vector1.push(1)
    else
      frag_vector1.push(0)
    end

    if vector2.include?(word) then
      frag_vector2.push(1)
    else
      frag_vector2.push(0)
    end
  end

  vector1_final = Vector.elements(frag_vector1, copy = true)
  vector2_final = Vector.elements(frag_vector2, copy = true)

  return vector2_final.inner_product(vector1_final)/(vector1_final.norm() * vector2_final.norm())

end
end
#pp Mecab.new("シャツ", "オックスフォードシャツ").calc_score
#pp calc_score(str1, str2)
