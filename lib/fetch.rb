class Fetch
  def self.index
    require 'mechanize'
    # === データを取得 ===
    submit = usersubmit
        
    # === データを加工 ===
    submit.sort! { |a, b| b['epoch_second'] <=> a['epoch_second'] }

    # === 前日の提出コードを取得 ===
    source_codes = []
    lastday_submits = lastday_submit_array(time, submit)

    lastday_submits.each do |i|
      url = "https://atcoder.jp/contests/#{i['contest_id']}/submissions/#{i['id']}"
      source_codes << fetch_source_code(url)
    end

    # === 問題文を取得 ===
    problem_statement = []

    lastday_submits.each do |i|
      url = "https://atcoder.jp/contests/#{i['contest_id']}/tasks/#{i['problem_id']}"
      problem_statement << fetch_problem_statement(url)
    end

    # ファイルに書き込み
    file_write(source_codes, problem_statement, lastday_submits)
  end

  def self.GetJsonAPI(urlstring)
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

  def self.usersubmit
    # === 特定のuserのデータを取得 ===
    username = "xryuseix"
    return GetJsonAPI("https://kenkoooo.com/atcoder/atcoder-api/results?user=" + username)
  end

  def self.time
    # === 昨日の日付を取得 ===
    now_unixtime = Time.new.to_i
    lastday_unixtime = now_unixtime - 60*60*24
    lastday = Time.at(lastday_unixtime)
    return lastday
  end

  def self.lastday_submit_array(lastday, submit)
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

  def self.fetch_source_code(url)
    # === 提出したソースコードを取得 ===
    agent = Mechanize.new
    page = agent.get(url)
    code = page.xpath('//*[@id="submission-code"]').text.gsub(/&gt/, ">").gsub(/&lt/, "<")
  end

  def self.fetch_problem_statement(url)
    # === 問題文を取得 ===
    agent = Mechanize.new
    page = agent.get(url)
    
    # 整形
    statement = page.xpath('//*[@id="main-container"]/div[1]/div[2]').text.gsub(/\n/, "").gsub(/\r/, "").gsub(/\t/, "").gsub(/入力例.+/, "")

    statement = statement.gsub(/Time Limit/, "\nTime Limit ").gsub(/Memory Limit/, "Memory Limit ").gsub(/配点/, "\n配点").gsub(/問題文/, "\n問題文 : ").gsub(/制約/, "\n制約")
    return statement
  end

  def self.file_write(source_codes, problem_statement, lastday_submits)
    # === データ(問題文・ソースコード)を書き込み ===

      # 書き込み先ディレクトリがなかったら作る
      lastday_submits.length.times do |i|
      if not is_exist_directory("#{Dir.pwd}/storage/", "#{Dir.pwd}/storage/AtCoder/")
        Dir.mkdir("#{Dir.pwd}/storage/AtCoder")
      end
      if not is_exist_directory("#{Dir.pwd}/storage/AtCoder/", "#{Dir.pwd}/storage/AtCoder/#{lastday_submits[i]['contest_id']}/")
        Dir.mkdir("#{Dir.pwd}/storage/AtCoder/#{lastday_submits[i]['contest_id']}")
      end

      # 書き込み
      File.open("#{Dir.pwd}/storage/AtCoder/#{lastday_submits[i]['contest_id']}/#{lastday_submits[i]['problem_id']}_#{lastday_submits[i]['id']}.txt", "w") do |f|
        url = "https://atcoder.jp/contests/#{lastday_submits[i]['contest_id']}/tasks/#{lastday_submits[i]['problem_id']}"
        f.puts("問題文の引用元：#{url}")
        f.puts(problem_statement[i])
        f.puts("\n\n\n")
        f.puts(source_codes[i])
      end
    end

  end

  def self.is_exist_directory(path, dir)
    # pathの中にdirというディレクトリがあるか確認する
    Dir.glob("#{path}*/").each do |directory_name|
      return true if directory_name == dir
    end
    return false
  end

end