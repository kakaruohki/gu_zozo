# kkr
##ローカルサーバでの環境構築
#github(https://github.com/kakaruohki/gu_zozo)より"gu_zozo"リポジトリをクローンしてください。
#bundlerを使用するため、ruby環境(2.3以上)を用意してください
#gem install bundler　を実行してください
#リポジトリ内でbundle install --path .bundle/　を実行してください
#使用するgooglechromeのバージョンに対応するchromedriverをダウンロードしてください(http://chromedriver.storage.googleapis.com/index.html)
#データベース作成
データベース名"gu"を作成
以下のクエリを実行
CREATE TABLE `zozo_gu_items` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `zozo_item` varchar(100) NOT NULL DEFAULT '',
  `zozo_rank` int(10) NOT NULL,
  `gu_item` varchar(50) NOT NULL DEFAULT '',
  `gu_img_url` varchar(100) NOT NULL DEFAULT '',
  `gu_url` varchar(100) NOT NULL DEFAULT '',
  `category` varchar(10) NOT NULL,
  `score` float unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
CREATE TABLE `items_alls` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `number` int(15) NOT NULL,
  `selling_price` int(15) unsigned NOT NULL,
  `img_url` varchar(100) NOT NULL DEFAULT '',
  `url` varchar(50) DEFAULT NULL,
  `category` varchar(10) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8;
#guマスターテーブル作成
bundle exec ruby gu_items_parse.rb を実行
#mecab
mecabを使用できる環境を整えてください。([参照]https://rooter.jp/data-format/mecab_install/)
#類似度の計算、データベースへの挿入
bundle exec ruby result.rb を実行
#webサーバの立ち上げ
bundle exec ruby sinatra/top.rb を実行
