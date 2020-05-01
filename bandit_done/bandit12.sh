#!/bin/bash

#This is dirty but it works
tm=dat
if [ -f "$tm" ]; then
	rm "$tm"
fi
cp data.txt dat
xxd -r dat > dat1

curFormat=""
outFile=""
workableFormat=""
curFile="dat1"
function work(){
	
	while [[ true ]]; do
		res=`file $curFile`

	if [[ $res =~ .*gzip.* ]]; then
		echo gzip ====================================
		 workableFormat="${curFile}.gz"
		cp $curFile $workableFormat
		outFile=`gzip -l $workableFormat | awk 'NR==2 {print $4}'`

		gzip -d $workableFormat
		curFile=$outFile
		echo $outFile
		echo $curFile #no change they should both be the same
		res=`file $outFile`
		echo $res
		echo "done gzippppppppppppppppppppppppppppppppppp"

	elif [[ $res =~ .*bzip2.* ]]; then
		echo bzip2 =============================
		workableFormat="${curFile}.bz2"
		mv $curFile $workableFormat
		bzip2 -d $workableFormat
		# outFile
		# curFile #no change they should both be the same
	elif [[ $res =~ .*tar.* ]]; then
		echo tar =============================
		workableFormat="${curFile}.tar"
		mv $curFile $workableFormat
		echo $curFile 
		echo $workableFormat
		outFile=`tar -t -f $workableFormat` #By so doing we get name of output file
		curFile=`tar -t -f $workableFormat` #By so doing we get name of output file

		tar -xvf $workableFormat
		res=`file $outFile`
		echo $outFile
		echo $res
				echo "done"
	elif [[ $res =~ .*ASCII.* ]]; then
		echo password: 
		cat $curFile | awk 'NR==1 {print $4}'
		break
	fi
	done
	
}

work 
echo $curFormat
echo $curFile

# snip snip
# done gzippppppppppppppppppppppppppppppppppp
# password:
# 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL

