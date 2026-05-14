# VPS4YOU DYNDNS — Automatic update of DNS record

$email      = "INSERT_YOUR_EMAIL_HERE"
$apikey     = "INSERT_YOUR_API_KEY_HERE"
$service    = "INSERT_YOUR_SERVICEID_HERE"
$apiUrl     = "https://vps4you.hu/api.php"
$hostname   = "INSERT_YOUR_HOSTNAME_ONLY_HERE"
$domain     = "INSERT_YOUR_DOMAIN_ONLY_HERE"
$fqdn       = "$hostname.$domain"

$currentIP = (Invoke-RestMethod -Uri "https://api.ipify.org").Trim()

#$currentIP = "88.77.66.55" -> For testing purposes only

$listBody = @{
    email = $email; apikey = $apikey
    action = "domain-dns-list"
    serviceid = $service; json = "1"
}
$listResult = Invoke-RestMethod -Uri $apiUrl -Method POST -Body $listBody
$records = $listResult.records | Where-Object { $_.name -eq $fqdn -and $_.type -eq "A" }

if ($records) {
    $dnsIP = @($records)[0].data

    if ($currentIP -eq $dnsIP) {
        Write-Host "IP has not changed: $currentIP — nothing to do"
        exit 0
    }

    Write-Host "IP changed: $dnsIP → $currentIP — Updating DNS..."

    foreach ($r in $records) {
        $deleteBody = @{
            email = $email; apikey = $apikey
            action = "domain-dns-delete"
            serviceid = $service; json = "1"
            recordid = $r.id
        }
        $delResult = Invoke-RestMethod -Uri $apiUrl -Method POST -Body $deleteBody
        Write-Host "Removed: ID $($r.id) → $($r.data) | Result: $($delResult.success)"
    }
} else {
    Write-Host "No existing record — Creating a new: $currentIP"
}

$createBody = @{
    email = $email; apikey = $apikey
    action = "domain-dns-add"
    serviceid = $service; json = "1"
    type = "A"; name = $hostname
    data = $currentIP
}
$result = Invoke-RestMethod -Uri $apiUrl -Method POST -Body $createBody

if ($result.success -eq $true) {
    Write-Host "DNS Updated successfully: $fqdn → $currentIP"
} else {
    Write-Error "Error updating the DNS: $($result | ConvertTo-Json)"
    exit 1
}