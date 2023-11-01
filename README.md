# Setting up SSH keys with YubiKey 


## Prerequisites

1. **Yubico PIV Tool Installation**: Ensure the Yubico PIV Tool is installed on your machine.
2. **YubiKey**: Your YubiKey should be inserted into a USB slot.
3. **OpenSSH**: Make sure OpenSSH is installed.

## Configuration & Setup

### 1. System PATH and `.dll` Configuration

The `add-ssh.ps1` script will automatically add the PIV Tool to your system's PATH.    
Another option is to add getopt.dll, key.pem, libcrypto-1_1-x64.dll, libykcs11.dll, libykpiv.dll to C:\Windows\System32\OpenSSH

### 2. SSH Configuration

After running the script, ensure you have the following configuration added to your SSH config to be able to use the ssh key:  

.ssh\config
```plaintext
Host mylinux
    HostName 192.168.10.1
    User admin
    Port 22
    PKCS11Provider libykcs11.dll
    LogLevel QUIET

```

### 3. Save the ssh cert and keys in keepass
It is a good idea to save the generated files in a secure location and remove them from the temp directory

### 4. List ssh public keys
```plaintext
 ssh-keygen.exe -D libykcs11.dll -e
```
