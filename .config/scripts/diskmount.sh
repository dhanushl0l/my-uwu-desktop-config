#!/bin/bash

# Network SMB mount
NETWORK_SHARE="//192.168.1.164/share1"
MOUNT_POINT="/mnt/share1"
USERNAME="dhanu"
PASSWORD="153269@"

# UUID for NTFS RAID drive
NTFS_UUID="/dev/disk/by-uuid/0A3A0F0D3A0EF58B"  # NTFS RAID drive UUID
NTFS_MOUNT="/mnt/bup"

# UUID for EXT4 single drive
EXT4_UUID="/dev/disk/by-uuid/b4a9db17-5b14-4f4a-b84e-114369e2e15d"  # EXT4 drive UUID
EXT4_MOUNT="/mnt/down"

# Create mount points if they don't exist
mkdir -p $MOUNT_POINT
mkdir -p $NTFS_MOUNT
mkdir -p $EXT4_MOUNT

# Mount the SMB network drive with explicit read-write permissions
echo "Mounting network share..."
pkexec mount -t cifs $NETWORK_SHARE $MOUNT_POINT -o username=$USERNAME,password=$PASSWORD,vers=3.0,file_mode=0777,dir_mode=0777,uid=1000,gid=1000,rw

# Check if SMB mount was successful
if mountpoint -q $MOUNT_POINT; then
    echo "Network share mounted successfully at $MOUNT_POINT."
else
    echo "Failed to mount network share."
    exit 1
fi

# Mount the NTFS RAID drive using UUID and specified options
echo "Mounting NTFS RAID drive..."
pkexec mount $NTFS_UUID $NTFS_MOUNT -o nosuid,nodev,nofail,x-gvfs-show

# Check if NTFS mount was successful
if mountpoint -q $NTFS_MOUNT; then
    echo "NTFS RAID drive mounted successfully at $NTFS_MOUNT."
else
    echo "Failed to mount NTFS RAID drive."
    exit 1
fi

# Mount the EXT4 drive using UUID and specified options
echo "Mounting EXT4 drive..."
pkexec mount $EXT4_UUID $EXT4_MOUNT -o nosuid,nodev,nofail,x-gvfs-show

# Check if EXT4 mount was successful
if mountpoint -q $EXT4_MOUNT; then
    echo "EXT4 drive mounted successfully at $EXT4_MOUNT."
else
    echo "Failed to mount EXT4 drive."
    exit 1
fi

echo "All drives mounted successfully."
