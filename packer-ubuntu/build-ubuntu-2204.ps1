# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2204"
$CONF_NAME="ubuntu-2204"
$VM_DIR_NAME="Ubuntu_22.04_64-bit"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME
