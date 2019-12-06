class FetchController < ApplicationController
  def index
    
    # === データを取得 ===
    submit = usersubmit
    # contest = contestinfo
    
    # === データを加工 ===
    submit.sort! { |a, b| b['epoch_second'] <=> a['epoch_second'] }

    # === 前日の提出コードを取得 ===
    source_codes = []
    lastday_submits = lastday_submit_array(time, submit)
  
    lastday_submits.each do |problemnum|
      url = "https://atcoder.jp/contests/#{problemnum['contest_id']}/submissions/#{problemnum['id']}"
      source_codes << fetch_source_code(url)
    end
    
  end

  def GetJsonAPI(urlstring)
    require 'net/http'
    require 'json'
    # === APIからJsonデータを取得 ===

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
    # === 特定のuserのデータを取得 ===
    username = "xryuseix"
    return GetJsonAPI("https://kenkoooo.com/atcoder/atcoder-api/results?user=" + username)
  end

  def contestinfo
    # === コンテストの情報を所得 ===
    return GetJsonAPI("https://kenkoooo.com/atcoder/resources/problems.json")
  end

  def time
    # === 昨日の日付を取得 ===
    now_unixtime = Time.new.to_i
    lastday_unixtime = now_unixtime - 60*60*24
    lastday = Time.at(lastday_unixtime)
    return lastday
  end

  def lastday_submit_array(lastday, submit)
    # === 前日の提出状況を配列で返す ===
    lastday_submits = []

    submit.each do |sub|
      submitday = Time.at(sub['epoch_second'])

      # 昨日の提出をlastday_submitsに格納
      if lastday.day == submitday.day && lastday.month == submitday.month && lastday.year == submitday.year
        if sub['result'] == "AC"
          lastday_submits << sub
        end
      elsif lastday.day > submitday.day
        # submitはソートしているのでdayが小さい値がくればbreak
        break
      end
    end
    return lastday_submits
  end

  def fetch_source_code(url)
    # === 提出したソースコードを取得 ===
    agent = Mechanize.new
    page = agent.get(url)
    code = page.xpath('//*[@id="submission-code"]').text.gsub(/&gt/, ">").gsub(/&lt/, "<")
  end

end
