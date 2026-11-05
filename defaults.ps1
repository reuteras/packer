# Default location for virtual machines
# Change the values below for your environment. You have to create the directories.

# Name and location of readonly folder to mount in VM
$SHARED_RO_NAME = "ro"
$SHARED_RO_PATH = "D:\Shared\ro"

# Name and location of writable folder to mount in VM
$SHARED_RW_NAME = "rw"
$SHARED_RW_PATH = "D:\Shared\rw"

# Folder to store VMs in after they are created
$VM_DIR = "D:\Virtual Machines"

# --- No need to edit below --- #

# Defaults for shared cache for Packer.
$env:PACKER_CACHE_DIR = "../packer_cache"
$env:CHECKPOINT_DISABLE = "1"
