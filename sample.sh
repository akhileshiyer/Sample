start='2019-01-01'
end='2019-02-01'

start=$(date -d $start +%Y%m%d)
end=$(date -d $end +%Y%m%d)

while [[ $start -le $end ]]
do
        echo $(date -d $start +%Y-%m-%d)
        start=$(date -d"$start + 1 day" +"%Y%m%d")

done
