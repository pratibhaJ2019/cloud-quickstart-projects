#!/bin/bash
# Do not edit this file for config. Edit the acommpanying config.sh

# This script will be run from a Makefile in the context of a directory with a config.sh
# file in it, so consider this relative path to be a reference to that directory and not
# the same directory as this wrapper script exists in.
source ./config.sh

export TF_VAR_DESIRED_HOSTNAME="$desired_hostname"
export TF_VAR_DOMAIN_NAME="$desired_domainname"
export TF_VAR_FQDN="$desired_hostname.$desired_domainname"
export TF_VAR_LETSENCRYPT_EMAIL="$letsencrypt_email"
export TF_VAR_AWS_PUBKEY="$ssh_pubkey_location"
export TF_VAR_AWS_PRIVKEY="$ssh_privkey_location"
export TF_VAR_GCP_PUBKEY="$ssh_pubkey_location"
export TF_VAR_GCP_PRIVKEY="$ssh_privkey_location"

export TF_VAR_MY_PUBLIC_IP="$(curl --silent -4 http://ipecho.net/plain)/32"

# Set some Ansible env vars
export ANSIBLE_HOST_KEY_CHECKING="False"
export ANSIBLE_NOCOWS="1" # Disable Cowsay support in Ansible (why, Red Hat?)

# If no argument provided, do not run script
if [ -z $1 ]
then
  echo "Please use the Makefile. Do not run this script directly."
elif [ -n $1 ]
then
  arg=$1
fi

case $arg in
   "--plan") exec terraform plan;;
   "--apply") exec terraform apply;;
   "--destroy") exec terraform destroy;;
   *) echo "Argument not recognised!";;
esac
