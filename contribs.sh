author=$1
git log -w --shortstat --author "$author" "${@:2}"\
    | grep "files\? changed" \
    | awk '{commits +=1; files+=$1; inserted+=$4; deleted+=$6} END \
           {print "Num commits:", commits, ". Inserted:", inserted, ". Deleted:", deleted}'
