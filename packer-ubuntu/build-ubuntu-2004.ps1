# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2004"
$CONF_NAME="ubuntu-2004"
$VM_DIR_NAME="Ubuntu_20.04_64-bit"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME