class Send
  def self.index
    lastday = time

    # This command is used at once.
    # git init; git remote add origin 'https://github.com/xryuseix/Competitive_Programming_Buckup';

    # This is remove command(for test).
    # system("cd storage; git rm -rf AtCoder/* ;")
    # system("cd storage; git add --all; git commit -m 'remove test script'; git push -u origin master")

    system("cd storage;
      echo 'AAAAA\n';
      git config --global user.email 'ryusei143.shootingstar@gmail.com';
      echo 'BBBBB\n';
      git config --global user.name 'xryuseix';
      echo 'CCCCC\n';
      git init;
      echo 'EEEEE\n';
      git remote add origin 'https://github.com/xryuseix/Competitive_Programming_Buckup';
      echo 'FFFFF\n';
      git pull origin master;
      echo 'DDDDD\n';
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