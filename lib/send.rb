class Send
  def self.index
    lastday = time

    # This command is used at once.
    # git init; git remote add origin 'https://github.com/xryuseix/Competitive_Programming_Buckup';

    # This is remove command(for test).
    # system("cd storage; git rm -rf AtCoder/* ;")
    # system("cd storage; git add --all; git commit -m 'remove test script'; git push -u origin master")

    # git config --global user.email 'ryusei143.shootingstar@gmail.com';
    # git config --global user.name 'xryuseix';
    # git init;
    # git remote add origin 'https://github.com/xryuseix/Competitive_Programming_Buckup';
    system("cd storage;git init")
    system("cd storage;ls -a")
    system("cd storage;echo 'AAAAA\n'")

    system("cd storage;git remote add origin 'https://github.com/xryuseix/AtCoder_Backup'")
    system("cd storage;echo 'BBBBB\n'")

    system("cd storage;git config --global user.email 'ryusei143.shootingstar@gmail.com'")
    system("cd storage;git config --global user.name 'xryuseix'")
    system("cd storage;echo 'CCCCC\n'")

    system("cd storage;git pull origin master;")
    system("cd storage;echo 'DDDDD\n'")
   
    system("cd storage;git add --all")
    system("cd storage;echo 'EEEEE\n'")

    system("cd storage;git commit -m '#{lastday.year}/#{lastday.month}/#{lastday.day}'")
    system("cd storage;echo 'FFFFF\n'")

    system("cd storage;git push -u origin master")
    system("cd storage;echo 'GGGGG\n'")

    
    
    # system("
    #   git add --all;
    #   echo 'HHHHH\n';
    #   git commit -m '#{time.year}/#{time.month}/#{time.day}';
    #   echo 'IIIII\n';
    #   git push -u origin master;
    #   echo 'JJJJJ\n';")
    
  end

  def self.time
    # === 昨日の日付を取得 ===
    now_unixtime = Time.new.to_i
    lastday_unixtime = now_unixtime - 60*60*24
    lastday = Time.at(lastday_unixtime)
    return lastday
  end

end