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
app_build_files="./dist/app"
buildFile="client-app.zip"

! [ -d $app_dir ] && mkdir $app_dir
[[ -d $app_dir && -d $client_dir ]] && rm -rf $client_dir

mkdir $client_dir

git clone https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront.git $client_dir
cd $client_dir

# Turn off analytics
export NG_CLI_ANALYTICS="false"

npm i -y
ng build --configuration production

# Remove any existing build file
if [ -e "$buildFile" ]; then
	echo "Found existing build file $buildFile"
  rm -f "$buildFile"
  echo "Removed build file $buildFile"
fi

# Zip build
echo "Zipping files..."
cd $app_build_files
zip -r ../$buildFile *
