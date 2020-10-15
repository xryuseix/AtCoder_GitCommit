class Fetch
    def self.index
        require 'mechanize'
        # === データを取得 ===
        submits = usersubmit
                
        # === データを加工 ===
        submits.sort! { |a, b| b['epoch_second'] <=> a['epoch_second'] }
  
        # ===提出コードを取得 ===
        finish = submits.length
        cnt = 0
        submits.each do |sub|
            cnt += 1
            puts("#{cnt}/#{finish} #{sub['problem_id']}_#{sub['id']}")
            # すでに登録されている場合
            if is_exist_file(sub['contest_id'], sub['problem_id'], sub['id'])
                next
            end
            if sub['result'] != "AC" || !sub['language'].start_with?("C++")
                next
            end
            code_url = "https://atcoder.jp/contests/#{sub['contest_id']}/submissions/#{sub['id']}"
            problem_statement_url = "https://atcoder.jp/contests/#{sub['contest_id']}/tasks/#{sub['problem_id']}"
            source_codes = fetch_source_code(code_url)
            problem_statement = fetch_problem_statement(problem_statement_url)
            file_write(sub, source_codes, problem_statement)
        end
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

    def self.fetch_source_code(url)
        # === 提出したソースコードを取得 ===
        begin
            agent = Mechanize.new
            page = agent.get(url)
            return code = page.xpath('//*[@id="submission-code"]').text.gsub(/&gt/, ">").gsub(/&lt/, "<")
        rescue => error
            puts error
        end
    end

    def self.fetch_problem_statement(url)
        # === 問題文を取得 ===
        sleep(5)
        
        begin
            agent = Mechanize.new
            page = agent.get(url)
            # 整形
            statement = page.xpath('//*[@id="main-container"]/div[1]/div[2]').text.gsub(/\n/, "").gsub(/\r/, "").gsub(/\t/, "").gsub(/入力例.+/, "")
            return statement = statement.gsub(/Time Limit/, "\nTime Limit ").gsub(/Memory Limit/, "Memory Limit ").gsub(/配点/, "\n配点").gsub(/問題文/, "\n問題文 : ").gsub(/制約/, "\n制約")
        rescue => error
            puts errorz
        end
    end

    def self.file_write(submit, source_code, problem_statement)
        # === データ(問題文・ソースコード)を書き込み ===
        # 書き込み先ディレクトリがなかったら作る
        unless is_exist_directory(submit['contest_id'])
            Dir.mkdir("#{Dir.pwd}/storage/AtCoder/#{submit['contest_id']}")
        end

        # 書き込み
        File.open("#{Dir.pwd}/storage/AtCoder/#{submit['contest_id']}/#{submit['problem_id']}_#{submit['id']}.txt", "w") do |f|
            problem_url = "https://atcoder.jp/contests/#{submit['contest_id']}/tasks/#{submit['problem_id']}"
            code_url = "https://atcoder.jp/contests/#{submit['contest_id']}/submissions/#{submit['id']}"
            f.puts("問題文の引用元：#{problem_url}")
            f.puts(problem_statement)
            f.puts("// ソースコードの引用元 : #{code_url}")
            f.puts("// 提出ID : #{submit['id']}")
            f.puts("// 問題ID : #{submit['problem_id']}")
            f.puts("// コンテストID : #{submit['contest_id']}")
            f.puts("// ユーザID : #{submit['user_id']}")
            f.puts("// コード長 : #{submit['length']}")
            f.puts("// 実行時間 : #{submit['execution_time']}")
            f.puts("\n\n\n")
            f.puts(source_code)
        end
    end

    def self.is_exist_directory(contest_id)
        return File.directory?("#{Dir.pwd}/storage/AtCoder/#{contest_id}")
    end

    def self.is_exist_file(contest_id, problem_id, id)
        return File.file?("#{Dir.pwd}/storage/AtCoder/#{contest_id}/#{problem_id}_#{id}.txt")
    end
end

Fetch.index

# p File.directory?("#{Dir.pwd}/storage/AtCoder/arc105")

# def is_exist_directory(contest_id)
#     p "#{Dir.pwd}/storage/AtCoder/#{contest_id}"
#     p File.directory?("#{Dir.pwd}/storage/AtCoder/#{contest_id}")
#     return File.directory?("#{Dir.pwd}/storage/AtCoder/#{contest_id}")
# end
# if is_exist_directory("arc105") == true
#     print("AAA\n")
# end