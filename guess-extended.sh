#!/bin/bash
random=$((1 + RANDOM % 10))

guesses=1

#ask for name
read -p "Hi! What's your name? " name

echo "Welcome $name, try to guess the random number"

#ask for input max 3 times
while [ $guesses -le 3 ]; do
    echo 'Attempt number #'$guesses
    #ask input
    read -p "Your guess? [n]: " guess

    #valid? ask again
    while [[ ! $guess =~ (^[1-9]$|^10$)  ]]; do
        read -p "Invalid input. Your guess? [n]: " guess
    done

    #correct?
    if [ $guess -eq $random ]; then
        echo "Correct! Number was:" $random
        won=TRUE
        break;
    else
        #if not correct => greater or less than 
        if [ $guess -lt $random ]; then 
            echo 'Higher';
        elif [ $guess -gt $random ]; then
            echo 'Lower';
        fi
    fi
    
    #increases number of guesses
    ((guesses+=1))
done

#if last guess was not correct
if [ $guess -ne $random ]; then
    echo 'Too bad! Out of attempts.'
    won=FALSE
fi

#correction when out of attempts
if [ $guesses -eq 4 ]; then ((guesses-=1)); fi;

#save stats to file
echo '---------' >> ./score.txt
echo "Name: $name" >> ./score.txt  
echo "Date: $(date)" >> ./score.txt
echo "Player won? $won" >> ./score.txt
echo "Number of used guesses: $guesses" >> ./score.txt
echo ' ' >> ./score.txt