# homebrew 安装 rbenv
brew install rbenv

# 列出可安装的 ruby 版本
rbenv install -l
# 安装 2.7.3
rbenv install 2.7.3
# 指定此文件夹的 ruby 版本
cd $HOME/....../viomi_app_ios
rbenv local 2.7.3
# 指定全局的 ruby 版本
rbenv global 2.7.3

# 使用 gem 安装 2.2.6 的 bundler
gem install bundler:2.2.6
# 使用 bundler 安装工程依赖的 ruby 库
cd $HOME/....../viomi_app_ios
bundle install

# 使用 cocoapods 安装 iOS 依赖的第三方
arch -x86_64 pod install



# 参考资料
# rbenv：https://ruby-china.org/wiki/rbenv-guide
# arch -x86_64：https://github.com/CocoaPods/CocoaPods/issues/10518