# Ruby 写的一些命令行小工具  

### 使用 cocoapods.rb 执行 pod install 的命令 
>
> cocoapods.rb 的功能是使用 cocoapods 安装第三方库。
> 有时单纯执行 pod install 时，如果本地库没更新，执行过程会报错；此脚本会在 pod install 执行失败时，判断是不是本地库没更新（使用字符串匹配报错 Log 来判断），如果没更新，则重新执行 pod install 命令并携带 --repo-update 参数。当 pod install  执行成功后，会打开当前目录的 .xcodeworkspace 工程文件。 


1. 去到 iOS 工程的根目录 

`cd $HOME/iOSProjects/ProjectDemo` 

2. 如果工程使用 Gemfile 来管理 Ruby 的库，先用 bundle 安装对应的库；如果没有 bundle，可跳过第 2 步 

`bundle install` 

3. 用 ruby 执行 cocoapods.rb 

`ruby $HOME/ruby/cocoapods.rb` 

4. 第 3 步的 shell 命令可以设置别名，如： 

`alias podinstall="ruby $HOME/ruby/cocoapods.rb"`
