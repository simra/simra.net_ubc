#!/bin/sh

if netstat -i | grep -q eth ; then 
    echo "Starting Port forwarding services..";
    ssh -N -L 25:smtp.cs.ubc.ca:25 simra@cascade.cs.ubc.ca &
    ssh -N -L 143:imap.cs.ubc.ca:143 simra@cascade.cs.ubc.ca &
    ssh -N -L 515:hobgoblin.cs.ubc.ca:515 simra@cascade.cs.ubc.ca &
    ssh -N -L 119:nnrp.cs.ubc.ca:119 simra@cascade.cs.ubc.ca &
    ssh -N -L 139:cs-smb.cs.ubc.ca:139 simra@cascade.cs.ubc.ca &
    sleep 1
    tries=0
    until netstat -l -A inet -n | grep -q "127.0.0.1:139" || [ $tries -gt 30 ] ; do
	echo "Waiting for SMB forward.";
	tries=$((tries+1))
	sleep 1;
    done
    if [ $tries -lt 30 ] ; then
	echo "Mounting Samba filesystems..";
	mount -t smbfs -o credentials=/etc/smbcredentials,uid=simra,gid=simra  //localhost/simra /home/ubc
    fi
fi
