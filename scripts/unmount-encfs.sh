# This script unmounts all the mounted encfs directories

SELECTOR=$1

case "$SELECTOR" in
    # Harddrive
    ("/Volumes/Horka"|"Horka"|"Harddisk"|"harddisk"|"harddrive")
        diskutil unmount ~/PrivateHarddisk
    ;;

    # Pendrive
    ("Levi"|"/Volumes/Levi 001"|"Pendrive"|"pendrive")
        diskutil unmount ~/Private
    ;;

    *)
        echo "Usage: unmount-encfs <hardisk | pendrive>"
    ;;
esac
