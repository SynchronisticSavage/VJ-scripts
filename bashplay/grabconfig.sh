IFS="="
while read -r name value
do
echo "Content of $name is ${value//\"/}"
done < lpHiR.cfg


