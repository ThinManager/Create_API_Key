<##################################################
 # # # # # # # # # # # # # # # # # # # # # # # # #

FILE: TM-API-LIB-config.ps1

PURPOSE: Parameters used for this powershell example. Change the api_url,
api_username, and api_password to match what you have on your system.

# # # # # # # # # # # # # # # # # # # # # # # # #
##################################################>

# URL to your ThinManager. NOTE: No trailing '/'
$global:api_url = 'https://localhost:8443/api'

# API Username & Password
# This user must be in the "Local Administrators" or other ThinManager Security Group.
$global:api_username = "ra-admin2@ra-lab.local"
$global:api_password = "rara"

# Initial headers to use for requests
$global:tokenheader = @{
    'accept' = "application/json"
	'Content-Type' = "application/json"
} 

$global:api_key = "<blank>"