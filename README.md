# VPS4YOU-DNS-UPDATER---POWERSHELL
VPS4YOU Dns Updater written in Powershell

Instrutions how to use this script:

$email      = "INSERT_YOUR_EMAIL_HERE" -> Insert here Your registrated email address at VPS4YOU.HU
$apikey     = "INSERT_YOUR_API_KEY_HERE" -> Insert here Your API key (You find it on the Profile page at VPS4YOU.HU)
$service    = "INSERT_YOUR_SERVICEID_HERE" -> Insert here Your SERVICEID key (You find it on the Services page at VPS4YOU.HU)
$apiUrl     = "https://vps4you.hu/api.php"
$hostname   = "INSERT_YOUR_HOSTNAME_ONLY_HERE" -> Insert here ONLY your desired HOSTNAME (for example MILKYWAY)
$domain     = "INSERT_YOUR_DOMAIN_ONLY_HERE" -> Insert here ONLY your registered domain name (MYSITE.COM)

The script create FQDN from $hostname and $domain variables
