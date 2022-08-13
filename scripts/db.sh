#!/bin/bash
#===============================================================================
#
#          FILE:  db.sh
# 
#         USAGE:  ./db.sh 
# 
#   DESCRIPTION: Operating systems. Linux's basics. Command line tools.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (Williams Afiukwa), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  08/10/2022 04:05:18 PM UTC
#      REVISION:  ---
#===============================================================================

ls
users_db_path=./data/users.db
backup_dir=./backup
req=$1

add(){
	read -p "Enter your username: " username

	while [[ -z $username ]]
			do
				read -p "Enter your username: " username
			done
	while [[ $username =~ [^[:lower:]] ]]; do
 		 echo "Only lowercase latin letters are allowed [a-z]"
		 read -p "Enter your username: " username
	done

	read -p "Enter your role: " role
	while [[ -z $role ]]
		do
			read -p "Enter your role: " role
		done
	while [[ $role =~ [^[:lower:]] ]]; do
			echo "Only lowercse latin letters are allowed [a-z]"
			read -p "Enter your role: " role
	done

	echo "$username,$role" >> $users_db_path
}

find(){
	echo Find
	echo -n "Enter username to find: "
	read username
	grep -i $username $users_db_path
}

list(){
	echo List
	declare -i count=1
	for i in $(cat $users_db_path)
	do
					echo "$count. $i"
					((count += 1))
	done
}

listReverse(){
	echo List Reverse
}

backup(){
	echo Backing up Database...

	! [ -d $backup_dir ] && mkdir $backup_dir

	cat $users_db_path > "$backup_dir/$(date +%s)-users.db.backup" && 
					echo "Backup successful" 
}

restore(){
	echo Restoring last backup...
	local bkps="$(ls $backup_dir)"
	[ -z ${bkps[0]} ] && echo "No backup found" && exit 1
	echo "Backup Found: ${bkps[0]}";
					cat "$backup_dir/${bkps[0]}" > $users_db_path && 
					echo "Successfully Restored DB to previous version"
}

help(){
	echo Help!!				
}

case $req in
				add) add;;
				find) find;;
				list) list;;
				backup) backup;;
				restore) restore;;
				help) help;;
				*) help;;
esac



echo;echo
echo ========================
echo 'Users'
echo ------------------------
cat $users_db_path
