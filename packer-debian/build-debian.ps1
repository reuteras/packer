# Load defaults
. ../defaults.ps1

$BASE="debian"
$CONF_NAME="debian"
$VM_DIR_NAME="Debian_64-bit"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME