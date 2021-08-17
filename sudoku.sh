#!/usr/bin/bash
# script to update the latest sudoku date and time on my portfolio's homepage
# add authentication
eval "$(ssh-agent -s)"
ssh-add '/mnt/c/users/Vivek Rao/Desktop/Programming/Miscellaneous/.ssh/id_ed25519'
# 'C:\Users\Vivek Rao\Desktop\Programming\Miscellaneous\.ssh\id_ed25519' # mnt/c/users/Vivek Rao\Desktop\Programming\Miscellaneous\.ssh\id_ed25519

# change working directory to portfolio repo
cd '/mnt/c/users/Vivek Rao/Documents/GitHub/Portfolio'

# download latest sudoku sheet
wget -q -O latest.file --no-check-certificate 'https://docs.google.com/spreadsheets/d/e/2PACX-1vSoqnPWcu7Vi2cUAIcH78PFITa-gaVWhQVeEpM4X0Nc4Nd0fHZk98xb221AL3byyU-qAiO4UcZmGrMl/pub?gid=0&single=true&output=csv'
# define variables of interest
latest_date=$(tail -n 1 latest.file | cut -d , -f 1)
latest_time=$(tail -n 1 latest.file | cut -d , -f 2)
# update the latest_date field
sed -i "s|<code id='latest_date'>.*</code> and|<code id='latest_date'>$latest_date</code> and|g" index.html
# update the latest_time field
sed -i "s|<code id='latest_time'>.*</code>|<code id='latest_time'>$latest_time</code>|g" index.html
# delete temp file
rm latest.file
# # push repo to GitHub to update
git add index.html
git commit -m "daily sudoku update"
git push -u origin master
sleep 10
