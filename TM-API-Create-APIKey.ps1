<##################################################
 # # # # # # # # # # # # # # # # # # # # # # # # #

FILE: TM-API-Create-APIKey.ps1

PURPOSE: The main body of code to be executed to generate a ThinManager
API key with specific permissions.

# # # # # # # # # # # # # # # # # # # # # # # # #
##################################################>

<##################################################>
# Must include these 2 lines in all TM-API based scripts
. .\TM-API-LIB.ps1
. .\TM-API-LIB-config.ps1

<##################################################>
################## Begin execution

Login-API

### Example to get the Terminal Tree
# $term_tree = Get-API '/terminals/tree'

### Example to get 1 terminal's information
# $terminal8 = Get-API '/terminals/terminal/8'

### Create a new API key
# Adjust the permissions. Only those permissions listed will be allowed for this API key
$newkey = @{
	"Name" = "New Key 6"
	"Quota" = 10000
	"QuotaPeriod" = 3600
	"DisableAt" = "01/31/25 22:22"
	"Permissions" = @(
		"Connect",
		"Shadow",
		"Interactive Shadow",
		"Reset Sessions",
		"Kill Processes",
		"Reboot Terminal Servers",
		"Connect To Terminal Servers",
  		"Logoff TermSecure Users",
  		"ThinServer Administration",
  		"Create Terminals",
  		"Create Users",
  		"Create Application Groups",
  		"Create Terminal Servers",
  		"Edit Terminals",
  		"Edit Users",
  		"Edit Application Groups",
  		"Edit Terminal Servers",
  		"Install Files",
  		"Calibrate Touchscreens",
  		"Reboot Terminals",
  		"Restart Terminals",
  		"Schedule Events",
  		"Change Licenses",
  		"Allow Printing",
  		"Create Cameras",
  		"Edit Cameras",
  		"View Cameras",
  		"Create VMWare",
  		"Edit VMWare",
  		"VMWare Operations",
  		"Create DHCP",
  		"Edit DHCP",
  		"Create Package",
  		"Edit Package",
  		"Create Location",
  		"Edit Location",
  		"Logoff Location",
  		"Create Resolver",
  		"Edit Resolver",
  		"Replace Terminal",
  		"ThinManager Server List",
  		"Create VNC",
  		"Edit VNC",
  		"Create Container",
  		"Edit Container",
		"Create Events",
  		"Edit Events"
	)
} # | ConvertTo-Json -Depth 100

# Send POST request to make new API
# $response = Post-API '/system/api/keys' $newkey

# Get list of current API keys
$current_keys = Get-API '/system/api/keys'

Write-Host "Current API keys:"
$current_keys.Content | ConvertFrom-Json | fl
Write-Host "----------------------------------------"

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
