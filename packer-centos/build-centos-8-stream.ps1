# Load defaults
. ../defaults.ps1

$BASE="centos-8-stream"
$CONF_NAME="centos-8-stream"
$VM_DIR_NAME="CentOS_8"

Create-VirtualMachine $BASE $CONF_NAME $VM_DIR_NAME