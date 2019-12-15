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
    system("cd storage;
      echo 'CCCCC\n';
      ls -a;
      echo 'AAAAA\n';
      git pull origin master;
      echo 'BBBBB\n';
      ls -a;
      echo 'GGGGG\n';
      git add --all;
      echo 'HHHHH\n';
      git commit -m '#{time.year}/#{time.month}/#{time.day}';
      echo 'IIIII\n';
      git push -u origin master;
      echo 'JJJJJ\n';")
    
  end

  def self.time
    # === 昨日の日付を取得 ===
    now_unixtime = Time.new.to_i
    lastday_unixtime = now_unixtime - 60*60*24
    lastday = Time.at(lastday_unixtime)
    return lastday
  end

end