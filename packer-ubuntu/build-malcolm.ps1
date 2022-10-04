# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2204"
$CONF_NAME="malcolm"
$VM_DIR_NAME="Malcolm"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME