require 'open3'
require 'colorize'

class ShellUtils
  # @param [Object] command
  # @param [Integer] retry_count
  # @return [Boolean<is_succeed>, Object<stdout>, Error<stderr>]
  def self.execute(command, retry_count = 1)
    puts("当前路径：#{Dir.pwd}")
    retry_count = 1 if retry_count <= 0

    stdout = nil
    stderr = nil
    status = 0
    idx = 1

    for i in 0..retry_count
      puts("开始执行命令（第#{idx}次）：#{command}".yellow)
      stdout, stderr, status = Open3.capture3(command)
      puts("命令执行完毕（第#{idx}次）：#{command}".yellow)

      if status.to_i.zero?
        status = status
        break
      else
        puts("命令执行报错（第#{idx}次：#{command}\nstdout: \n#{stdout}\nstderr: \n#{stderr}\n")
        puts('即将重试') if idx < retry_count
      end

      idx = 1 + idx
    end

    [stdout, stderr, status]
  end
end