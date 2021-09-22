ruby_tools_dir = "#{ENV['HOME']}/ruby"

require 'colorize'
require 'FileUtils'
require "#{ruby_tools_dir}/ShellUtils"

# project_path = ENV["PROJECT_PATH"]
# Dir.chdir(project_path)
puts("当前工作目录: #{Dir.pwd}".green)
podfile_path = "#{Dir.pwd}/Podfile"
unless File.exist?(podfile_path)
  puts('Podfile 文件不存在'.red)
  exit(-1)
end
puts('Podfile 文件存在'.green)

def open_xcode_project
  stdout, stderr, status = ShellUtils.execute("open #{Dir.pwd}/*.xcworkspace")
  puts(:成功打开项目工程) if status.to_i.zero?
end

def pod_install(bundle_command)

  # arch_prefix = ''
  # stdout, stderr, status = ShellUtils.execute('arch')
  # if stdout.to_s == 'arm64'
  #   puts("Apple M1 arm64 架构".blue)
  #   arch_prefix = 'arch -x86_64 '
  # else
  #   puts("Intel X86 架构".blue)
  #   arch_prefix = ''
  # end

  pod_install_command = "#{bundle_command}pod install"
  pod_install_repo_update_command = "#{bundle_command}pod install --repo-update"
  puts("开始执行 #{pod_install_command}")
  stdout, stderr, status = ShellUtils.execute(pod_install_command)
  if status.to_i.zero?
    puts("#{pod_install_command} 执行成功".green)
    open_xcode_project
  elsif stdout.include?('could not find') || stdout.include?('Unable to find')
    puts("开始执行 #{pod_install_repo_update_command}")
    stdout, stderr, status = ShellUtils.execute(pod_install_repo_update_command)
    if status.to_i.zero?
      puts("#{pod_install_repo_update_command} 执行成功\n#{stdout}".green)
      open_xcode_project
    else
      puts("Pod install 执行失败\n#{stdout}".red)
    end
  else
    puts("Pod install 执行失败\n#{stdout}".red)
  end
end

# @return [nil]
def bundle_process

  bundle_command = 'bundle exec '
  gemfile_path = "#{Dir.pwd}/Gemfile"

  if !File.exist?(gemfile_path)
    bundle_command = ''
  else
    bundle_install_command = 'bundle install'
    stdout, stderr, status = ShellUtils.execute(bundle_install_command)
    unless status.to_i.zero?
      puts("#{bundle_install_command} 执行失败\n#{stderr}".red)
      # bundle install 失败的话，直接退出，手动处理报错
      exit(status.zero?)
    end
  end
  pod_install(bundle_command)
end

bundle_process


