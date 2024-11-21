# Get the list of devices from `arp -a`
$arpTable = arp -a

# Extract IP addresses from the ARP table
$ips = ($arpTable | ForEach-Object { $_ -match "(\d{1,3}\.){3}\d{1,3}" } | ForEach-Object { $Matches[0] })

# Define the message
$message = "Hello World!"

# Loop through each IP and send the message
foreach ($ip in $ips) {
    try {
        # Use msg command to send the message
        msg * /server:$ip $message
    } catch {
        Write-Host "Failed to send message to $ip"
    }
}
