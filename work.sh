~/bin/parse.rb <(git log --author=Alex --no-merges  --date=format:"%F" --format="%ad %s" --shortstat --since=1/1/17 ) > alex-all.csv 
