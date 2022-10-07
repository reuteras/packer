# Load defaults
. ../defaults.ps1

$BASE="centos-7"
$CONF_NAME="centos-7"
$VM_DIR_NAME="CentOS_7"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME