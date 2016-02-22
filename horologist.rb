#!/usr/bin/env ruby

# This file is part of Horologist.
# (c) Jesus Leon <git@jes.mx>
# For the full copyright and license information, please view 
# the LICENSE file that was distributed with this source code.

require 'fileutils'
require 'date'
require 'time'

class Horologist

  BASE_DIR = "~/.horologist"
  METHODS = ['now', 'past']

  def run(arguments)
    if(arguments[0].nil?)
        puts "\e[1m\e[35m"+"Horology—the art or science of measuring time."+"\e[0m\e[22m"
        puts
        showHelp()
    end

    if(! self.isMethod(arguments[0]))
      showHelp()
    end

    if(! self.isReady)
      self.install()
      self.init()
    end

    self.send(arguments[0], arguments[1])
  end

  def isReady()
    self.isDir(File.expand_path(BASE_DIR))
  end

  def install()
    puts "\e[1m"+"This is a one time configuration. Hold on a bit."+"\e[22m"
    puts
    puts "\e[1m"+"Installing dependencies..."+"\e[22m"
    
    installed = system("sudo gem install chronic")

    if(! installed)
      puts "\e[31m"+"Error: Couldn't install dependency."+"\e[0m"
      puts "Try manually: sudo gem install chronic"
    end

    installed = system("sudo gem install random-word")

    if(! installed)
      puts "\e[31m"+"Error: Couldn't install dependency."+"\e[0m"
      puts "Try manually: sudo gem install random-word"
    end
  end

  def init(a=nil, b=nil)
    puts
    puts "\e[1m"+"Initializing..."+"\e[22m"

    system("cp horologist.rb /usr/local/bin/horologist")

    FileUtils.mkdir_p(File.expand_path(BASE_DIR))

    self.gotoHorologistDir()
    
    system("git init > /dev/null")
    system("git config user.name 'Horologist'")
    system("git config user.email 'horologist@timespace'")

    self.git_commit("** Horologist is ready **");
    
    puts "\e[1m\e[32m"+"Horologist is ready"+"\e[0m\e[22m"
    puts
  end

  def now(message)
    require 'random-word'

    self.gotoHorologistDir()

    message ||= "Point in time - " + "\e[1m"+RandomWord.nouns.next+"\e[22m"
    
    self.git_commit(message);
    
    puts "\e[35m"+"✓\e[0m " + message
  end

  def past(date)
    require 'chronic'

    self.gotoHorologistDir()
    
    command = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%ai%C(reset) - %C(white)%s%C(reset) %C(dim white)' --all"

    unless date.nil?
      dates = date.split('..')
    end

    if(!date.nil? && dates.length >= 1)
      command = command + " --since '" + Chronic.parse(dates[0]).to_s + "'"
    end

    if(!date.nil? && dates.length >= 2)
      command = command + " --until '" + Chronic.parse(dates[1]).to_s + "'"
    end

    system(command)
  end

  def git_commit(message)
    system("git commit --allow-empty -m '" + message + "' > /dev/null")
  end

  def gotoHorologistDir()
    Dir.chdir File.expand_path(BASE_DIR)
  end

  def isDir(directory)
    File.directory?(directory)
  end

  def isMethod(method)
    METHODS.include? method
  end

  def showHelp()
    puts "\e[1m"+"Usage:"+"\e[22m"
    puts "    horology {command} {arguments}"
    puts
    puts "\e[1m"+"Commands:"+"\e[22m"
    puts "    now      {current_activity}"
    puts "    past     {date|since_date..until_date}"
    exit
  end

end

h = Horologist. new
h.run(ARGV)
