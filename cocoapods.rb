require 'open3'
require 'colorize'
require 'FileUtils'

# project_path = ENV["PROJECT_PATH"]
# Dir.chdir(project_path)
puts("当前工作目录: #{Dir.pwd}".blue)
podfile_path = "#{Dir.pwd}/Podfile"
if !File.exist?(podfile_path)
  puts("Podfile 文件不存在".red)
end

puts("Podfile 文件存在".green)

def open_xcode_project
  stdout, stderr, status = Open3.capture3("open #{Dir.pwd}/*.xcworkspace")
  puts(:成功打开项目工程) if status.to_i.zero?
end

pod_install_command = 'bundle exec pod install'
pod_install_repo_update_command = 'bundle exec pod install --repo-update'
puts("开始执行 #{pod_install_command}")
stdout, stderr, status = Open3.capture3(pod_install_command)
if status.to_i.zero?
  puts("#{pod_install_command} 执行成功".green)
  open_xcode_project
elsif stdout.include?('CocoaPods could not find compatible versions for pod')
  puts("开始执行 #{pod_install_repo_update_command}")
  stdout, stderr, status = Open3.capture3(pod_install_repo_update_command)
  if status.to_i.zero?
    puts("#{pod_install_repo_update_command} 执行成功\n#{stdout}".green)
  else
    puts("Pod install 执行失败\n#{stdout}".red)
  end
else
  puts("Pod install 执行失败\n#{stdout}".red)
end
