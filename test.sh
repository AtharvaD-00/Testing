#!/bin/bash
# Shell script to test the basic calculator

# Description of the test case file entries
: '
	Test case file format :
	
	<Operation name> <Sign>
	<Input 1> <Input 2> <Expected output> <Case description>
	.
	.
	.
	
'

# Retrieves the test cases' file name from the command line
testfile="$1"

# Checks if the test cases' file exists
if [ -z $testfile ] || ! [ -e $testfile ];
then
	echo "Please enter the name of an existing file ..."
	exit 1
fi

# Checks if the test cases' file has read permissions
if ! [ -r $testfile ];
then
	chmod +r $testfile
fi

# Assigns the output file
reportfile="report.txt"

# Checks if the output file exists; emptying it if it does and creating it if not
if ! [ -e $reportfile ];
then
	touch $reportfile
else
	> $reportfile
fi

# Checks if the output file has write permissions
if ! [ -w $reportfile ];
then
	chmod +w $reportfile
fi

# Assigns the sign and count variables with blank values initially
sign=""
count=0

# Reads the file of test cases line by line
while IFS=\  read -r ip1 ip2 result desc;
do

	# Deals with blank lines
	if [[ -z "$ip1" ]];
	then
		echo >> $reportfile

	# Deals with the start of a set of tests for a new operation
	elif [[ -z "$result" ]];
	then
		echo "$ip1 :" >> $reportfile
		sign="$ip2"
		count=1

	# Deals with a test case
	else
		# Runs the calculator using the test case inputs, suppressing any arising errors
		op=$(python3 calculator.py $ip1 "$sign" $ip2 2> /dev/null)

		# Checks if the test case is handled as expected or not
		if [[ "$op" = "$result" ]]
		then
			echo "$count. Performs correctly for $desc" >> $reportfile
		else
			echo "$count. Performs incorrectly for $desc" >> $reportfile
		fi
		
		((count++))
	fi

done < $testfile
