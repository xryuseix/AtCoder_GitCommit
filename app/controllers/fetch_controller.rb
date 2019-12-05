class FetchController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    submit = usersubmit
    contest = contestinfo
    
  end

  def GetJsonAPI(urlstring)
    # urlをパース
    url = URI.parse(urlstring)
    # httpの通信を設定
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    # リクエストを作成・送信
    req = Net::HTTP::Get.new(url)
    res = https.request(req)
    
    # データ変換
    hash = JSON.parse(res.body)
    
    return hash
  end

  def usersubmit
    username = "xryuseix"
    return GetJsonAPI("https://kenkoooo.com/atcoder/atcoder-api/results?user=" + username)
  end

  def contestinfo
    return GetJsonAPI("https://kenkoooo.com/atcoder/resources/problems.json")
  end

end
