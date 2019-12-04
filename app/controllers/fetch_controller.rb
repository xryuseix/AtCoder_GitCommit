class FetchController < ApplicationController
  def index
    puts("hello")
    atcoder
  end
  def atcoder
    require 'net/http'
    require 'json'

    # urlをパース
    url = URI.parse("https://kenkoooo.com/atcoder/atcoder-api/results?user=wata")
    
    # httpの通信を設定
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    # リクエストを作成・送信
    req = Net::HTTP::Get.new(url)
    res = https.request(req)
    
    # データ変換
    hash = JSON.parse(res.body)
    
    puts hash
  end
end
