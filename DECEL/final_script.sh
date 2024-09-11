
#!/bin/bash


echo "Program starts"


# Define a function to map values to notes
get_note_frequency() {
    if [ "$register" == "E3" ]; then
    fr_1=707
    fr_2=718
    decelrl -wr 0 15
    decelrl -wr 1 $fr_1
    decelrl -wr 2 $fr_2
    decelrl -wr 3 255
    decelrl -wr 4 255
    mosquitto_pub -h oracle23nl.me -p 21883 -m "    STOP" -t decel/ef41a0/disp/str -u decel -P decel2023
    echo "STOP"
    else
    frequency=0
    fr=0
    decelrl -wr 0 0
    mosquitto_pub -h oracle23nl.me -p 21883 -m "   CLEAR" -t decel/ef41a0/disp/str -u decel -P decel2023
    echo "CLEAR"
    fi
}


# Infinite loop to continuously ask for input
while true; do
    register=$(mosquitto_sub -h oracle23nl.me -p 21883 -t decel/ef41a0/out -u decel -P decel2023 -C 1)
    if [ $? -ne 0 ]; then
     echo "Error: failed to write register"
        exit 1
    fi
    get_note_frequency $register_value
done