class Send
  def self.index
    lastday = time


    system("cd storage;git init")
    # system("cd storage;ls -a")

    system("cd storage;git remote add origin 'https://github.com/xryuseix/AtCoder_Backup'")
    
    # system("cd storage;echo 'git remote -v\n'")

    domain = '@' + 'gmail.com'
    system("cd storage;git config --global user.email 'ryusei143.shootingstar#{domain}'")
    system("cd storage;git config --global user.name 'xryuseix'")


    system("cd storage;git pull origin master")
   
    system("cd storage;git add --all")

    system("cd storage;git commit -m 'submit of #{lastday.year}/#{lastday.month}/#{lastday.day} rand=#{rand(100000)}'")
    cmd = 'cd storage;git push origin master'
    exec_as_root(cmd)

    
    
  end

  def self.time
    # === 昨日の日付を取得 ===
    now_unixtime = Time.new.to_i
    lastday_unixtime = now_unixtime - 60*60*24
    lastday = Time.at(lastday_unixtime)
    return lastday
  end

end