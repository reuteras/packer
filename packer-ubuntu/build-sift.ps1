# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2004"
$CONF_NAME="sift"
$VM_DIR_NAME="SIFT"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME