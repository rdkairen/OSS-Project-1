
echo "--------------------------"
echo "User Name: 이준혁"
echo "Student Number: 12223793"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item’"
echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’"
echo "4. Delete the ‘IMDb URL’ from ‘u.item"
echo "5. Get the data about users from 'u.user’"
echo "6. Modify the format of 'release date' in 'u.item’"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"
while true; do
    read -p "Enter your choice [ 1-9 ] " c
    echo

    if [ "$c" -eq 1 ]; then
	    read -p "Please enter 'movie id' (1~1682): " num
        echo
        awk -F'|' -v id="$num" '$1 == id {print $0}' $1
        echo

    elif [ "$c" -eq 2 ]; then
        read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n) : " y
        echo
        if [ "$y" = "y" ]; then
                awk -F'|' '$7 == 1 {print $1, $2}' $1 | head -10
        echo
        fi

    elif [ "$c" -eq 3 ]; then
        read -p "Please enter the 'movie id(1~1682)' : " num
        echo
        awk -v id="$num" -F'\t' 'BEGIN {count=0} $2 == id {sum+=$3; count++} END {printf "average rating of %d: %.5f\n", id, sum/count}' $2
        echo

    elif [ "$c" -eq 4 ]; then
        read -p "Do you want to delete the 'IMDD URL' from 'u.item'?(y/n) : " y
	echo
        if [ "$y" = "y" ]; then
                sed 's/|http[^|]*|/||/' $1 | head -10
        echo
	fi
    elif [ "$c" -eq 5 ]; then
        read -p "Do you want to get the data about users from 'u.user'?(y/n) : " y
	echo
        if [ "$y" = "y" ]; then
                awk -F'|' '{print "user " $1 " is " $2 " years old " $3 " " $4}' $3 | sed 's/M/male/g' | sed 's/F/female/g' | head -10
        echo
	fi

    elif [ "$c" -eq 6 ]; then
        read -p "Do you want to get the data abiut users from 'u.user'? (y/n) : " y
	echo
	if [ "$y" = "y" ]; then
        	awk -F'|' '{ split($3, date, "-"); $3 = date[3] date[2] date[1]; print $1 "|" $2 "|" $3 "|" $4 "|" $5 "|" $6 "|" $7 "|" $8 "|" $9 "|" $10 "|" $11 "|" $12 "|" $13 "|" $14 "|" $15 "|" $16 "|" $17 "|" $18 "|" $19 "|" $20 "|" $21 "|" $22 "|" $23 "|" $24 }' $1 | sed -e 's/Jan/01/g' -e 's/Feb/02/g' -e 's/Mar/03/g' -e 's/Apr/04/g' -e 's/May/05/g' -e 's/Jun/06/g' -e 's/Jul/07/g' -e 's/Aug/08/g' -e 's/Sep/09/g' -e 's/Oct/10/g' -e 's/Nov/11/g' -e 's/Dec/12/g' | tail -10
	echo
	fi

    elif [ "$c" -eq 7 ]; then
    	read -p "Please enter the 'user id'(1~943): " num
    	echo
    	awk -v id="$num" -F'\t' '$1 == id {print $2}' $2 | sort -n | tr '\n' '|' | sed 's/|$//'
	echo
	echo
    	awk -v id="$num" -F'\t' '$1 == id {print $2}' $2 | sort -n | while read mid
    	do
        	awk -v id="$mid" -F'|' '$1 == id {print $1"|"$2}' $1
		((count++))
		if((count==10)); then
			echo
			break
		fi
    	done

    elif [ "$c" -eq 8 ]; then
        read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n) : " y
	echo


    elif [ "$c" -eq 9 ]; then
        echo "bye!"
        exit 0
    else
        echo "Invalid choice."
    fi
done
