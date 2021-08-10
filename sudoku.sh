# script to update the latest sudoku date and time on my portfolio's homepage



# download latest sudoku sheet
/usr/bin/wget -oq --no-check-certificate 'https://docs.google.com/spreadsheets/d/e/2PACX-1vSoqnPWcu7Vi2cUAIcH78PFITa-gaVWhQVeEpM4X0Nc4Nd0fHZk98xb221AL3byyU-qAiO4UcZmGrMl/pub?gid=0&single=true&output=csv'

# define variables of interest
latest_date=$(tail -n 1 'pubgid=0&single=true&output=csv' | cut -d , -f 1)
latest_time=$(tail -n 1 'pubgid=0&single=true&output=csv' | cut -d , -f 2)
echo $latest_time, $latest_date

# update the latest_date field
sed -i "s|<code id='latest_date'>.*</code> and|<code id='latest_date'>$latest_date</code> and|g" index.html

# update the latest_time field
sed -i "s|<code id='latest_time'>.*</code>|<code id='latest_time'>$latest_time</code>|g" index.html

# delete temp files
rm  q
rm 'pubgid=0&single=true&output=csv'

# push repo to GitHub to update
git add index.html
git commit -m "daily sudoku update"
git push -u origin master
sleep 5
