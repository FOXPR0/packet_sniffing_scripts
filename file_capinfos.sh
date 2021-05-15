red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`






read -p "What is the time zone (default Asia/Kolkata) :  " t
###### testing valid timezone enter

              if [ ! -z "$t" ]
                then

                       timedatectl list-timezones | grep -w $t
                       r=`echo $?`
                                if  [ $r -eq 0 ] ;then
                                        echo $t "in this time zone"
                                else
                                        echo " I dont see the timezone $t in the timedatectl list" $y

                                fi



                else
                        t=Asia/Kolkata
#                        echo "default time zone is" $t

                fi





echo -e "\n \n"

echo " ${red}$#  ${reset} capture  provided " 
echo "${red}~~~ ${reset}"

for x in "$@" 
do   

echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++"
echo  "${red}$x ${reset}  :--"
#echo "**"  $y  " ** filter"
#echo $t "in this time zoyyne"





#echo " Aanalysis will be capture in ${green}/tmp/$x.analysis.$$.txt ${reset} "




TZ="$t"  capinfos -aeu -r $x  


echo -e "============================================== \n " 
done
