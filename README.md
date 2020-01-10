# AtCoder_GitCommit
readmeは執筆中です

AtCoderに提出したコードを自動でGitHubにバックアップをとるプログラム
このコードによって作成されたレポジトリは[こちら](https://github.com/xryuseix/AtCoder_Backup)です

## Usage

1. cloneします

```sh
$ git clone https://github.com/xryuseix/AtCoder_GitCommit
```
2. lib/send.rbの6~10行目とlib/fetch.rbの54行目を編集してください

※以降はherokuで実行する場合，サーバーをお持ちならそちらでも可能です

3. herokuへ登録し，デプロイします

4. herokuの環境変数「Git_ID」にIDを，「Git_PW」にパスワードを保存します．

5. herokuのaddonのスケジューラに時刻を設定します
