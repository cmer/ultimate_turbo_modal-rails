#!/usr/bin/env ruby

def js_dependencies_commands
  commands = ["cd #{@path}"]

  case js_bundler
  when :yarn
    commands << "yarn add el-transition morphdom"
  when :npm
    commands << "npm install el-transition morphdom"
  when :importmap
    commands << "bin/importmap pin el-transition morphdom"
  end

  commands
end

def rails_dependencies_commands
  commands = [
    "cd #{@path}",
    "bundle add view_component",
    "mkdir -p app/components"
  ]
end

def copy_files_commands
  commands = [
    "mkdir -p #{File.join(@path, "app/components/ui")}",
    "mkdir -p #{File.join(@path, "app/javascript/controllers")}",
    "cp app/components/ui/modal.rb #{File.join(@path, "app/components/ui/")}",
    "cp app/components/ui/modal.html.erb #{File.join(@path, "app/components/ui")}",
    "cp app/javascript/controllers/modal_controller.js #{File.join(@path, "app/javascript/controllers")}"
  ]
end

def run
  puts ""
  puts "----------------------------------------------"
  puts "Welcome to the Ultimate Turbo Modal for Rails!"
  puts "----------------------------------------------"
  puts ""
  puts "This script will install the Ultimate Turbo Modal for Rails into your application."
  puts "Some files may get overwritten. Make sure you have a `git commit` of your last working"
  puts "version, just in case you need to rollback!"
  puts ""
  puts "BUT DON'T WORRY! I will list all the commands so you can review them before they are executed."
  puts ""
  puts "Press Enter to continue. To abort, press Ctrl+C."
  puts "\nInstalling the Ultimate Turbo Modal for Rails..."

  if js_bundler
    puts "\nJavacript dependencies..."
    if print_and_prompt_commands(js_dependencies_commands)
      execute_commands(js_dependencies_commands)
    end
  else
    puts "No Javascript bundler detected. Please install the Javascript dependencies manually."
  end

  puts "\nRails dependencies..."
  if print_and_prompt_commands(rails_dependencies_commands)
    execute_commands(rails_dependencies_commands)
  end

  puts "\nCopying files..."
  if print_and_prompt_commands(copy_files_commands)
    execute_commands(copy_files_commands)
  end

  puts "\nInstallation done, BUT YOU'RE NOT DONE!"
  puts "Please refer to the README, there are some manual steps you need to take."
  puts ""
end

def start
  @path = ARGV[0].to_s.strip

  if @path.to_s.strip == ""
    puts "Please specify the path to your Rails application."
    puts "Example: ruby install.rb /path/to/my/rails/app"
    exit 1
  end

  if !File.directory?(@path)
    puts "The specified path does not exist."
    exit 1
  end

  if !File.exist?(File.join(@path, "Gemfile")) ||
       !File.exist?(File.join(@path, "config", "application.rb"))
    puts "The specified path does not seem to be a Rails application."
    exit 1
  end

  run
end

def print_and_prompt_commands(commands)
  puts "The following commands will be executed:"

  commands.each { |command| puts "  $ #{command}" }

  answer = nil

  while answer.nil?
    print "\nDo you want to execute these commands? [Y/n] "
    answer = input
    return true if answer == "y" || answer == ""
    return false if answer == "n"
    answer = nil
  end
end

def yarn?
  File.exist?(File.join(@path, "yarn.lock"))
end

def npm?
  File.exist?(File.join(@path, "package.json"))
end

def importmap?
  File.exist?(File.join(@path, "config", "importmap.rb"))
end

def js_bundler
  return :yarn if yarn?
  return :npm if npm?
  return :importmap if importmap?
  nil
end

def execute_commands(commands)
  IO.popen("/bin/sh", "r+") do |p|
    commands.each do |command|
      puts "Executing `#{command}`..."
      p.puts(command)
    end
  end
end

def input
  $stdin.gets("\n").strip.downcase
end

start
