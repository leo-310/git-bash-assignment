#! usr/bin/bash

 if which gpg >/dev/null ; then #Checking if GPG is installed.
    echo "GPG is installed"
  else
    echo "GPG not installed. Please install GPG and try again."
    echo "Refer : https://gnupg.org/download/"
    exit 1
fi

 if which git >/dev/null; then #Checking if Git is installed.
    echo "Git is Installed"
else
    echo "Git not Installed. Please install Git and try again."
    echo "Refer : https://git-scm.com/downloads"
    exit 1
 fi

function gpgConfig {
  local gpgKeyId="$1"
  git config --global user.signingkey "$gpgKeyId"
  git config --global commit.gpgsign true
  gpg --armor --export "$gpgKeyId" >publicKey.asc
  cat publicKey.asc
  echo "Copy this public key and paste it into a new GPG key in your GitHub account if you haven't already."
  exit 1
}

if ! gpg --list-secret-keys --keyid-format=long | grep -q "sec"; then #Checking the existence of the word sec
  echo "No GPG key found. Generating a new key..."
  gpg --full-generate-key #Generating new key
  gpgKeyId=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2 | tail -n 1 ) #Extracting the key ID
  gpgConfig "$gpgKeyId"
else
  echo "Please choose from the following option :"
  echo "Enter 1 : To use an existing key."
  echo "Enter 2 : To generate a new key."
  echo "Enter 3 : To delete an existing key."
  read -r input
  if [ "$input" -eq 1 ]; then
    echo "Using an existing key..."
    gpg --list-secret-keys --keyid-format=long
    echo "Enter the GPG key from after sec : "
    read gpgKeyId
    gpgConfig "$gpgKeyId"
  elif [ "$input" -eq 2 ]; then
    echo "Generating a new key..."
    gpg --full-generate-key
    gpgKeyId=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2 | tail -n 1)
    gpg --list-secret-keys --keyid-format=long
    echo "Choose your signing key from the above available keys : "
    read gpgKeyId
    gpgConfig "$gpgKeyId"
  elif [ "$input" -eq 3 ]; then
    gpg --list-secret-keys --keyid-format=long
    echo "Enter the key ID to be deleted : "
    read -r keyId
    gpg --delete-secret-key "$keyId"
    gpg --delete-key "$keyId"
    exit 0
  else
    echo "Invalid input. Exiting..."
    exit 1
  fi
fi

count=$(gpg --list-keys | grep -c "^pub") #Counting the number of keys

if [ "$count" -gt 1 ]; then
  gpg --list-secret-keys --keyid-format=long
  echo "Enter the Key ID you want to use for Git signing:"
  read -r gpgKeyId
  gpgConfig "$gpgKeyId"
else
  gpgKeyId=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2)
  gpgConfig "$gpgKeyId"
fi
