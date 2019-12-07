class SendController < ApplicationController
  def index

    system('cd storage; ls')
    system('git init')
    system('git remote add origin https://github.com/xryuseix/Competitive_Programming_Buckup')
    system('git add --all')
    system('git commit -m "first commit"')
    system('git push -u origin master')
    
  end
end
