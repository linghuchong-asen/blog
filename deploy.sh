#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 先推送master分支到远程master分支
git add -A
git commit -m '增加配置'
git pull git@github.com:linghuchong-asen/blog.git master
git push git@github.com:linghuchong-asen/blog.git master:master

# 推送构建文件到gh-pages
push_addr=git@github.com:linghuchong-asen/blog.git # git提交地址
commit_info=`git describe --all --always --long`
dist_path=docs/.vuepress/dist # 打包生成的文件夹路径
push_branch=gh-pages # 推送的分支

# 生成静态文件
yarn build

# 进入生成的文件夹
cd $dist_path

git init
git add -A
git commit -m "deploy, $commit_info"
git push -f $push_addr HEAD:$push_branch

cd -
rm -rf $dist_path
