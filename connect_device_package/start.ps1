# requires: Python, PowerShell, Permission to run PS scripts
# permissions for this PS session only:   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# exit if cmdlet gives error
$ErrorActionPreference = "Stop"

# Check to see if root CA file exists, download if not
If (!(Test-Path ".\root-CA.crt")) {
    "`nDownloading AWS IoT Root CA certificate from AWS..."
    Invoke-WebRequest -Uri https://www.amazontrust.com/repository/AmazonRootCA1.pem -OutFile root-CA.crt
}

# install AWS Device SDK for Python if not already installed
If (!(Test-Path ".\aws-iot-device-sdk-python")) {
    "`nInstalling AWS SDK..."
    git clone https://github.com/aws/aws-iot-device-sdk-python
    cd aws-iot-device-sdk-python
    python setup.py install
    cd ..
}

"`nRunning pub/sub sample application..."
python aws-iot-device-sdk-python\samples\basicPubSub\basicPubSub.py -e a38xmmz8qjranh-ats.iot.us-east-2.amazonaws.com -r root-CA.crt -c DGP_qt.cert.pem -k DGP_qt.private.key
