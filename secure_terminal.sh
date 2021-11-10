#!/bin/bash

trap '' 2

AUTH=0
ATTEMPT=0

while true;
do

#blocks user after 4 attempts
#----------------------------
if [ $ATTEMPT -gt 4 ]
then
break
fi
#----------------------------

#login interface
#----------------------------
echo "Number of Attempts: $ATTEMPT"
echo -n "Enter Password: "
read -s PASSWORD_INPUT
echo ""
#----------------------------

#gets the sha512 hash of the input from the user
#----------------------------
PASSWORD=$(echo $PASSWORD_INPUT | sha512sum)
#----------------------------

#compares the inputed hashed password to this hash
#----------------------------
if [[ $PASSWORD = *"a059aeb4ee4520745e7b6f0c1ddffa0ca319988d821f4defd3359202cf80919655827b86437e741ed7121443ef924dc353f7e68de5751828f50598193143575e"* ]];
then
AUTH=$((1 + $AUTH))
break
else
ATTEMPT=$((1 + $ATTEMPT))
fi
#----------------------------

done

#if the user is blocked they will be sent to this loop
#----------------------------
while [ $AUTH = 0 ]
do
clear
echo "Access Denied!"
sleep 15
done
#----------------------------

#if the user enters the right credentials they will be sent to this loop
#----------------------------
while [ $AUTH = 1 ]
do

echo -n "> "
read COMMAND
#if the command has any of these phrases in it the command will not be exacuted
#--------------------------------------------------------------
if [[ $COMMAND = *"touch"* ]] || [[ $COMMAND = *"rm"* ]] || [[ $COMMAND = *"cat"* ]] || [[ $COMMAND = *"echo"* ]] || [[ $COMMAND = *"git"* ]] || [[ $COMMAND = *"apt"* ]] || [[ $COMMAND = *".sh"* ]] || [[ $COMMAND = *"sudo"* ]] || [[ $COMMAND = *"wget"* ]] || [[ $COMMAND = *"python"* ]] || [[ $COMMAND = *"make"* ]] || [[ $COMMAND = *"open"* ]];
then
echo "Command Invalid!"
else
TERMINAL_OUTPUT=$($COMMAND 2< /dev/null)

#if the commands output shows the name of the file it will output "Invalid Output!"
#----------------------------
if [[ $TERMINAL_OUTPUT = *"secure_terminal.sh"* ]];
then
echo "Invalid Output!"
else
echo "$TERMINAL_OUTPUT"
fi
#----------------------------

fi
#--------------------------------------------------------------

done
