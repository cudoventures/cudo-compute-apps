# Search for all blank disks then auto partition, format, and mount disks
for disk in $(lsblk -dn -o NAME,TYPE | awk '$2=="disk"{print $1}'); do
    if ! lsblk /dev/$disk | grep -q part; then
        echo "Found unpartitioned disk: /dev/$disk"

        # Partition the disk
        parted -s /dev/$disk mklabel gpt
        parted -s /dev/$disk mkpart primary ext4 0% 100%

        sleep 2

        # Format
        mkfs.ext4 -F /dev/${disk}1

        # Mount point
        MOUNT_POINT="/mnt/${disk}1"
        mkdir -p $MOUNT_POINT
        mount /dev/${disk}1 $MOUNT_POINT
        echo "Disk /dev/$disk mounted at $MOUNT_POINT"
    else
      # Disk is already partitioned and formatted, just mount all partitions
        while IFS=' ' read -r part type mount_point; do
#           echo "Partition: $part, Type: $type, Mount Point: $mount_point"
            if [ -z "$mount_point" ]; then
              new_mount_point="/mnt/$part"
              mkdir -p $new_mount_point
              mount /dev/$part $new_mount_point
              echo "Partition /dev/$part mounted at $new_mount_point"
            fi
        done < <(lsblk -r -n -o NAME,TYPE,MOUNTPOINT /dev/$disk | awk '$2=="part"')

    fi
done
