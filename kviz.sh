#!/bin/bash

# konstansok
kerdesek=kerdesek.txt
pont1=0
pont2=0

# van-e kerdes
if [ ! -f $kerdesek ]
then
    echo "Nincsenek kerdesek!"
    exit 1
fi

# jatekmenet
exec 3<&0
 while IFS=';' read -ra kerdes; do
      currentQuestion="${kerdes[0]}"
      answer1="${kerdes[1]}"
      answer2="${kerdes[2]}"
      answer3="${kerdes[3]}"
      rightAnswer="${kerdes[4]}"
      # kerdesek kiirasa
          echo " $currentQuestion"
          echo " a, $answer1"
          echo " b, $answer2"
          echo " c, $answer3"
      # valasz bekerese
      read -p "Első játékos válasza: " valasz1 <&3
      read -p "Második játékos válasza: " valasz2 <&3
     if [ "$valasz1" == "$rightAnswer" ]
     then
         pont1=$(( ++pont1 ))
     fi
      if [ "$valasz2" == "$rightAnswer" ]
     then
         pont2=$(( ++pont2 ))
     fi

          echo "A jó válasz a '$rightAnswer' volt"
          echo "A pontok állása:"

 done < "$kerdesek"
if (($pont1==$pont2))
    then 
        echo "Első játékos - $pont1"
        echo "Második játékos - $pont2"
elif (($pont1>$pont2))
    then 
          echo "Első játékos - $pont1"
          echo "Második játékos - $pont2"
    else 
          echo "Második játékos - $pont2"
          echo "Első játékos - $pont1"
fi

 # https://unix.stackexchange.com/questions/453646/bash-prompting-for-user-input-while-reading-file
