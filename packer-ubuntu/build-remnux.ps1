# Load defaults
. ../defaults.ps1

$BASE="ubuntu-2004"
$CONF_NAME="remnux"
$VM_DIR_NAME="REMnux"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME