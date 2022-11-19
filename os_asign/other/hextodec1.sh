#!/bin/bash
read -p "Dividend? " dividend
read -p "Divisor? " divisor
    if [ $divisor = "0" ]
        then
            echo "∞"
    else
        echo "$((scale=4;$dividend / $divisor))" | bc
    fi