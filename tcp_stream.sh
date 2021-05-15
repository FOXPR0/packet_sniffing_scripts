red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`


#### Testing valid pcap file
#if test -f "$x"; then
#             # echo "$x is the file for shell script."
#                tshark -nr $x  -q
#                m=`echo $?`
#                if  [ $m -eq 0 ] ;then
#                        echo "Capture file" $x
#                else
#                        echo "Invalid file for tshark" $x
#                        exit;
#                fi
#else
#        echo "Press ESC key to quit or enter to select manually"
#        # read a single character
#        read -r -n1 key
#
#                # if input == ESC key
#                if [[ $key == $'\e' ]];
#                then
#                exit;
#                fi
#
#        echo "$x selecting file manually"
#
#fi



read -p "Provide filter : " y
####### Testing if the valid filter enter
#tshark -nr $x  -q -Y "$y"
#q=`echo $?`

#if  [ $q -eq 0 ] ;then
#        echo "filter used is  a valid filter" $y
#else
#        echo "invalid filter quiting" $y
#        exit;
#fi






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

echo -e "\n ++++++++++++++++++++++++++++++++++++++++++++"
echo  "${red}$x ${reset} capture is in progress"
#echo "**"  $y  " ** filter"
#echo $t "in this time zoyyne"





echo " Aanalysis will be capture in ${green}/tmp/$x.analysis.$$.txt ${reset} "




for i in `TZ="$t" tshark -nr $x -Y "$y" -T fields -e tcp.stream | sort| uniq 2> /dev/null`; do echo  -e "\n Stream number $i"; echo  -e "+++++++++++++++++++++++++ \n 
TTl 	tcp.time_delta         frame.time			ip.src           ip.dst            Info  \n -------------------------------------------------------------------------------------------------------------------------------------"; TZ="$t" tshark -nr $x -Y "tcp.stream == $i" -T fields -e ip.ttl -e tcp.time_delta -e frame.time -e ip.src -e ip.dst -e col.Info; echo "________________________________________________" ; done > /tmp/$x.analysis.$$.txt


echo -e "============================================== \n " 
done

