#!/bin/bash
random=$((1 + RANDOM % 10))

guesses=1

echo 'Try to guess the random number'

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
fi

