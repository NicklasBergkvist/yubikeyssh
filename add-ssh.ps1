# Add PIV Tool to PATH
$envPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
$newPath = "$envPath;C:\Program Files\Yubico\Yubico PIV Tool\bin\"
[System.Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")

# Define a temporary folder
$tempfolder = "c:\temp\"
if (-not (Test-Path $tempfolder)) {
    New-Item -ItemType Directory -Path $tempfolder
}

$priv = "$tempfolder\key.pem"
$pub = "$tempfolder\public.pem"
$cert = "$tempfolder\cert.pem"

# Generate the RSA private key
& "C:\Program Files\OpenSSL-Win64\bin\openssl.exe" genrsa -out $priv 2048

# Extract the public key
& "C:\Program Files\OpenSSL-Win64\bin\openssl.exe" rsa -in $priv -outform PEM -pubout -out $pub

# Interact with the YubiKey
& "C:\Program Files\Yubico\Yubico PIV Tool\bin\yubico-piv-tool.exe" -adelete-certificate -s9a # -k "<management key>"
& "C:\Program Files\Yubico\Yubico PIV Tool\bin\yubico-piv-tool.exe" -s 9a -a import-key -i $priv # -k "<management key>"
& "C:\Program Files\Yubico\Yubico PIV Tool\bin\yubico-piv-tool.exe" -a verify-pin -a selfsign-certificate --valid-days 3333 -s 9a -S "/CN=SSH key/" -i $pub -o $cert
& "C:\Program Files\Yubico\Yubico PIV Tool\bin\yubico-piv-tool.exe" -a import-certificate -s 9a -i $cert # -k "<management key>"
