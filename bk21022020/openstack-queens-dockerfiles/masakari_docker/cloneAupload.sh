total=1

while read line; do
filepath=${line:10}

filename=$(basename $filepath)
filedir=$(dirname $filepath)
echo $filename
echo $filedir
((total++))



linkFile="http://nova.clouds.archive.ubuntu.com/ubuntu/"    
linkFile+=${line:10}
wget $linkFile

linkupload="root@172.16.30.89:/repo/nova.clouds.archive.ubuntu.com/ubuntu"
linkupload+=$filedir



echo $filename
echo $linkupload
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Conlai: "+$total
echo "  "
echo "====================================================================================="

sshpass -p 'Vttek@123' scp $filename $linkupload
	
done < filename.txt
