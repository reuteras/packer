# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2204"
$CONF_NAME="arkime"
$VM_DIR_NAME="Arkime"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME
