# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2404"
$CONF_NAME="ubuntu-2404"
$VM_DIR_NAME="Ubuntu_24.04_64-bit"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME
