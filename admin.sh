#!/bin/bash
#Andrew Lorimer 041056170 lori0030@algonquinlive.com
#This program displays a menu system to the user to print out a list of users(P), List the user groups(L), Add a new user(A), Create a welcome file for the user(C), or quit the menu(Q)




source shapes.sh Line 60 '#'
echo
echo
echo "Hello $USER"
echo "Welcome to the System Administration menu"
echo
source shapes.sh Line 60 '#'
echo
echo
echo "Note that there are administration function that will ask"
echo  "for an administration password."
echo 
source shapes.sh Line 60 '#'
echo



 

	

while true;
do
	
echo
echo  "Enter your choice:"
echo  "(P)rint out a list of users"
echo  "(L)ist the user groups"
echo  "(A)dd a new user"
echo  "(C)reate a welcome file for a user"
echo  "(Q)uit the menu" 
read option

 

case $option in 
	#list users and groups
	"p"|"P")

echo ""
source shapes.sh Line 60 '#'
echo 
echo
echo "Actual Users of the System"
awk -F ':' '9000>$3 && $3>=1000 {print $1}'  /etc/passwd
echo
source shapes.sh Line 60 '#' ;;
#List groups where groups with * are other groups. Other groups can also be identified by the green * (BONUS) 
        "L"|"l")
	RED='\033[0;31m'
awk -F ':' '9000>$3 && $3>=1000 && $3=$4  {print $1}'  /etc/passwd
awk -F ':' '9000>$3 && $3>=1000 && $4 != ""  {printf "\033[32m*\033[0m" $1}' /etc/group

	;;
#This case will add a user and ask the user if they want to add information
        "a"|"A")
 echo "Enter a login name for the user to be added"
 read 
 echo "Adding user $REPLY ..."
num=$(awk -F ':' 'END {print $3+1 }' /etc/passwd) 
echo "Adding new group '$REPLY'($num) ..."
echo "Adding new user '$REPLY'($num) with group '$REPLY' ..."
echo "Creating home directory '/home/$REPLY' ... "
echo "Copying files from '/bin/sh' ...."
sudo useradd $REPLY
sudo passwd $REPLY
name=$REPLY

yesno="n"
while [[ $yesno = "n" || $yesno = "Y" ]];
do	
echo " Changing the user information for $name "
echo " Enter the new value or press ENTER for the default "
read -p "Full Name []: " fname ; 
read -p "Room Number []: " room  ;  
read -p "Work Phone []: " work  ; 
read -p "Home Phone []: "  phone ; 
read -p "Other []: " other ;
read -p ":Is the information correct [y/n]" yesno;
done
echo "$name is created"
sudo usermod -c " $fname $room $work $phone $other" $name

source shapes.sh Line 60 '#'

	;;
#This case will make a file in the new users home directory
"c"|"C")
	name=$(awk -F ':' 'END {print $1}' /etc/passwd)
      sudo touch welcome_readme.text /home/$name
	echo "Welcome to the system $name."



	;;
#This case will end the program
"q"|"Q")
       	echo "quitting program" 
       	exit 1;;

*) echo "invalid option" ;;
esac
done
