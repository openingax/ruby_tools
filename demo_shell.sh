### 执行 cocoapods 的命令
# 1. 去到 iOS 工程的根目录
cd $HOME/iOSProjects/ProjectDemo
# 2. 先用 bundle 安装对应的库，如果没有 bundle，则需要先安装对应的环境
bundle install
# 3. 用 ruby 执行 cocoapods.rb
ruby $HOME/ruby/cocoapods.rb
# 4. 第 3 步的 shell 命令可以设置别名，如：
alias podinstall="ruby $HOME/ruby/cocoapods.rb"

