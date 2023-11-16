# File to decrypt
encrypted_file="secret.txt.gpg"

# Iterate through 4-digit numeric passcodes (0000 to 9999)
for ((i=0; i<=9999; i++))
do
    # Format the number as a 4-digit string with leading zeros
    current_passcode=$(printf "%04d" $i)
    echo "Trying passcode: $current_passcode"

    # Attempt to decrypt the file with the current passcode
    echo "$current_passcode" | gpg --batch --yes --passphrase-fd 0 --output decrypted_file.txt --decrypt $encrypted_file &> /dev/null

    # Check the exit status of the decryption attempt
    if [ $? -eq 0 ]; then
        echo "File decrypted successfully with passcode: $current_passcode"
        exit 0
    fi
done

echo "Could not decrypt the file with a 4-digit numeric passcode."
exit 1

