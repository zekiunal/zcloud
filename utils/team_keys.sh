#!/bin/bash
# grab users public keys from github and write into a file

echo -e "# keys from github\n" > public.keys

for user in evren evrenkutar kunthar ali; do
  echo -e "# $user \n" >> public.keys
  curl https://github.com/$user.keys >> public.keys
  echo -e "\n" >> public.keys
done;
