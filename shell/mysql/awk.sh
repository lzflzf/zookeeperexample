#!/bin/awk -f
#check on how many fields in the file
#to call eg:./fieldcheck.awk MAX=8 FS=":" /etc/passwd


{
        if(NF>1)   
	{
                for(i=1;i<NF;i++)
		{
			printf("%srepay_num\":%s,\"interest",$i,i)
		}
		{
			print $NF
		}
	}
        else
		{
                	print $1
		}
        fi
}

