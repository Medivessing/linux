#!/bin/bash

# konstansok
kerdesek=kerdesek.txt
pont1=0
pont2=0
i=1

# színek
RED='\033[0;31m'
GREEN='\033[032m'
ORANGE='\033[033m'
BLUE='\033[034m'
PURPLE='\033[035m'
NC='\033[0m' # No Color

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
            printf "\n"
            printf "$i. "
            echo -e "${PURPLE}$currentQuestion${NC}"
            echo " a, $answer1"
            echo " b, $answer2"
            echo " c, $answer3"
            printf "\n"
        # valaszok bekerese
        printf "${GREEN}Első játékos válasza:${NC} "
        read -r valasz1 <&3
    until [ "$valasz1" == "a" ] || [ "$valasz1" == "b" ] || [ "$valasz1" == "c" ]
    do 
        echo -e "${RED}Adj meg egy helyes betűt!${NC}"
        printf "${GREEN}Első játékos válasza:${NC} "
        read -r valasz1 <&3
    done
    if [ "$valasz1" == "$rightAnswer" ] 
    then
        pont1=$(( ++pont1 ))
    fi
        printf "${BLUE}Második játékos válasza:${NC} "
        read -r  valasz2 <&3
    until [ "$valasz2" == "a" ] || [ "$valasz2" == "b" ] || [ "$valasz2" == "c" ]
    do 
        echo -e "${RED}Adj meg egy helyes betűt!${NC}"
        printf "${BLUE}Második játékos válasza:${NC} "
        read -r  valasz2 <&3
    done
    if [ "$valasz2" == "$rightAnswer" ] 
    then
        pont2=$(( ++pont2 ))
    fi
    printf "\n"
    echo -e "A jó válasz a(z) ${ORANGE}'$rightAnswer'${NC} volt"
    i=$(( ++i ))
done < "$kerdesek"
# pontok kiírása
echo "A pontok állása:"
printf "\n"
if (($pont1==$pont2))
    then 
        echo -e "${ORANGE}Döntetlen!${NC}"
        echo "*Első játékos* - $pont1"
        echo "*Második játékos* - $pont2"
elif (($pont1>$pont2))
    then 
        echo -e "Az ${ORANGE}első${NC} játékos nyert!"
        echo -e "${ORANGE}*Első játékos* - $pont1${NC}"
        echo "Második játékos - $pont2"
    else 
        echo -e "A ${ORANGE}második${NC} játékos nyert!"
        echo -e "${ORANGE}*Második játékos* - $pont2${NC}"
        echo "Első játékos - $pont1"
fi
$SHELL
# https://unix.stackexchange.com/questions/453646/bash-prompting-for-user-input-while-reading-file
