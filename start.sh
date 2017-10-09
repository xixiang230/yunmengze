sudo yum -y install gcc-c++ openssl-devel
sudo curl -sL https://rpm.nodesource.com/setup | sudo bash -
sudo yum install -y nodejs
npm install -g hexo-cli
sudo npm install -g hexo-cli
npm install hexo --save
git config --global user.name "xixiang230"
git config --global user.email "371524660@qq.com"
ssh-keygen -t rsa -C "371524660@qq.com"
cat /home/liuzekun/.ssh/id_rsa.pub
ssh -T git@github.com
npm install hexo-generator-index --save
npm install hexo-generator-archive --save
npm install hexo-generator-category --save
npm install hexo-generator-tag --save
npm install hexo-server --save
npm install hexo-deployer-git --save
npm install hexo-deployer-heroku --save
npm install hexo-deployer-rsync --save
npm install hexo-deployer-openshift --save
npm install hexo-renderer-marked --save
npm install hexo-renderer-stylus --save
npm install hexo-generator-feed --save
npm install hexo-generator-sitemap --save
npm install hexo-tag-vimhighlight --save
