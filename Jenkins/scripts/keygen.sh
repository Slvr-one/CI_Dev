#!/usr/bin/env bash
set -euo pipefail

# //////////////  VARS  //////////////////////////////////////

. .env
name=$1
id="id_ed25519_$name"

# //////////////  GENERATE ssh key  //////////////////////////////////////

ssh-keygen -qf ~/.ssh/$id -t ed25519 -C "$name\/"

# //////////////  PROMPT  //////////////////////////////////////

id_ed=$(cat ~/.ssh/$id)
id_ed_pub=$(cat ~/.ssh/$id.pub)

echo -e "\n ---private_key:  --$id--  \n\n $id_ed \n"
echo -e "\n ---public_key:  --$id.pub--  \n\n $id_ed_pub \n"

# //////////////  SEND generated data to .env file  //////////////////////////////////////

#echo "id_ed='$id_ed'" >> .env
#echo "is_ed_pub='$id_ed_pub'" >> .env


