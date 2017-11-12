### 遍历文件

datapath=/opt/data1

for dir in `ls $datapath`
do
   echo $dir
   filename=`ls $datapath"/"$dir"/" | grep 'csv$'`
   sh BASH_REMATCH.sh ${datapath}"/"${dir}"/"${filename} ${filename}
done



