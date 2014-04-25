#!/usr/bin/env bash
#
# Password encryptor and and decryptor.
# Authored by: Gerald Z. Villorente
# @2014 X-TEAM
#
#  ENC:
#  echo -n 'plainText' | openssl enc -bf -nosalt -a -K CAFEBABE -iv CAFEBABE
#
#  DEC:
#  echo 'euyThoE1Yg/lx605bYqGwA==' | openssl enc -bf -nosalt -a -d -K CAFEBABE -iv CAFEBABE
#
bold=`tput bold`
normal=`tput sgr0`
#
#
PASSWORD=$2
#
#
function usage() {
  echo "
    ${bold}USAGE${normal}

    To encrypt a plain text password.

    ${bold}./password.sh encrypt plainText${normal}
    ${bold}./password.sh -e plainText${normal}

    To decrypt an encrypted password.

    ${bold}./password.sh decrypt euyThoE1Yg/lx605bYqGwA==${normal}
    ${bold}./password.sh -d euyThoE1Yg/lx605bYqGwA==${normal}

    Make sure that this script is executable. If not, you can add execute
    property using ${bold}$ chmod +x password.sh${normal}.
  "
  exit
}

# Decrypt the encrypted password.
function decrypt() {
  echo ${PASSWORD} | openssl enc -bf -nosalt -a -d -K CAFEBABE -iv CAFEBABE
  echo ""
}

# Encrypt plain text password.
function encrypt() {
  echo -n ${PASSWORD} | openssl enc -bf -nosalt -a -K CAFEBABE -iv CAFEBABE
}

if [ -z "$1" ]; then
  echo "Missing first argument."
  usage
  exit
else
  # Check if the supplied parameter is --help.
  # Display the help if true.
  if [ "$1" == "--help" ]; then
    usage
  fi

  if [ -z "$2" ]; then
    echo "Missing second argument."
  else
    if [ "$1" == "-e" ] || [ "$1" == "encrypt" ]; then
      encrypt
    fi

    if [ "$1" == "-d" ] || [ "$1" == "decrypt" ]; then
      decrypt
    fi
  fi
fi
