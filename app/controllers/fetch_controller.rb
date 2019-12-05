class FetchController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    
    # === データを取得 ===
    submit = usersubmit
    contest = contestinfo
    
    # === データを加工 ===
    submit.sort! { |a, b| b['epoch_second'] <=> a['epoch_second'] }

    # === 昨日の提出コードを取得 ===
    lastday_submits = lastday_submit_array(time, submit)
    
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

  def time
    now_unixtime = Time.new.to_i
    lastday_unixtime = now_unixtime - 60*60*24
    lastday = Time.at(lastday_unixtime)
    return lastday
  end

  def lastday_submit_array(lastday, submit)
    lastday_submits = []

    submit.each do |sub|
      submitday = Time.at(sub['epoch_second'])

      # 昨日の提出をlastday_submitsに格納
      if lastday.day == submitday.day && lastday.month == submitday.month && lastday.year == submitday.year
        lastday_submits << sub
      elsif lastday.day > submitday.day
        # submitはソートしているのでdayが小さい値がくればbreak
        break
      end
    end
    return lastday_submits
  end
end
