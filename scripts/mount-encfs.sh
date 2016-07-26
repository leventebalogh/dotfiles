# This script mounts the encrypted directories on a mounted Volume.

function dialog {
    MESSAGE=$1
    osascript -e "tell app \"System Events\" to display dialog \"$MESSAGE\""
}

function mountIfEncrypted {
    MOUNT_PATH=$1

    case "$MOUNT_PATH" in
        # Harddrive
        "/Volumes/Horka")
            SOURCE="$MOUNT_PATH/Private"
            DEST="/Users/leventebalogh/PrivateHarddisk"
            mountEncfs $SOURCE $DEST
            openMountedDirectory $DEST
            ;;
        # Pendrive
        "/Volumes/Levi 001")
            SOURCE="$MOUNT_PATH/Private"
            DEST="/Users/leventebalogh/PrivateHarddisk"
            mountEncfs $SOURCE $DEST
            openMountedDirectory $DEST
            ;;
    esac
}

function mountEncfs {
    PASSWORD=`security find-generic-password -a enfs -gw`
    SOURCE=$1
    DEST=$2
    echo $PASSWORD | encfs -S $SOURCE $DEST
}

function openMountedDirectory {
    sleep 1
    DIRECTORY=$1
    open $DIRECTORY
}

# Loop mounted volumes
for directory in /Volumes/* ; do
    mountIfEncrypted $directory
done
