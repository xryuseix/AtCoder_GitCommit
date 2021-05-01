![Ruby](https://img.shields.io/badge/Ruby-2.6.5-C21253.svg?logo=ruby) ![Heroku](https://img.shields.io/badge/Heroku-430098.svg?logo=heroku)

# AtCoder_GitCommit

AtCoder に提出したコードを自動で GitHub にバックアップをとるプログラム
このコードによって作成されたレポジトリは[こちら](https://github.com/xryuseix/AtCoder_Backup)です

## 更新時間

2:00 AM (JST) = 5:00 PM (UTC)

## Usage

1. clone します

```sh
$ git clone https://github.com/xryuseix/AtCoder_GitCommit
```

2. src/send.rb の 6~10 行目と src/fetch.rb の 54 行目と src/exp.ruby の 14 行目を編集してください

※以降は heroku で実行する場合，サーバーをお持ちならそちらでも可能です

3. heroku へ登録し，デプロイします

4. heroku の環境変数「Git_ID」に ID を，「Git_PW」に GitHub Personal access tokens を保存します．

5. heroku の addon のスケジューラに時刻を設定します
