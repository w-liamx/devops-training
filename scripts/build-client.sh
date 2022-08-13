#!/bin/bash
#===============================================================================
#
#          FILE:  build-client.sh
# 
#         USAGE:  ./build-client.sh 
# 
#   DESCRIPTION:  Build Angular app
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (Williams Afiukwa), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  08/12/2022 11:12:33 AM UTC
#      REVISION:  ---
#===============================================================================

app_dir=./apps
client_dir="$app_dir/angular-app"

! [ -d $app_dir ] && mkdir $app_dir
[[ -d $app_dir && -d $client_dir ]] && rm -rf $client_dir

mkdir $client_dir

git clone https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront.git $client_dir
cd $client_dir

echo 'export NG_CLI_ANALYTICS=ci' >> $BASH_ENV
npm i -y
npm run build
