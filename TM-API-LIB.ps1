<##################################################
 # # # # # # # # # # # # # # # # # # # # # # # # #

FILE: TM-API-LAB.ps1

PURPOSE: Functions used in the TM-API-Create-APIKey.ps1 script

# # # # # # # # # # # # # # # # # # # # # # # # #
##################################################>

Write-Host "----------------------------------------"
Write-Host "ThinManager API Script Library loaded."
Write-Host "----------------------------------------"

##################################################
# Global variable declarations

# What Powershell version is installed. 
#  Default to version 5
$global:ps_version = 5

# Initial headers to use for requests
$global:tokenheader = @{
    'accept' = "application/json"
	'Content-Type' = "application/json"
} 

##################################################
# Powershell version check. 
#  Check what version of Powershell is installed and adjust environment accordingly
#  This is ran when this script is included [ . ] in another script.

$global:ps_version = $PSVersionTable.PSVersion.Major

Write-Host "Powershell Major Verion: $global:ps_version"

if ($global:ps_version -eq 5) {
	# Run the following code if Powershell is version 5
	Write-Host "Applying Powershell 5 certificate check override."

	# Override the certificate validation call
	if (-not("dummy" -as [type])) {
	    add-type -TypeDefinition @"
	using System;  using System.Net;  using System.Net.Security;  using System.Security.Cryptography.X509Certificates;

	public static class Dummy {
	    public static bool ReturnTrue(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; }
	    public static RemoteCertificateValidationCallback GetDelegate() { return new RemoteCertificateValidationCallback(Dummy.ReturnTrue); }
	}
"@ #Must be the first character of the line.
	}
	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = [dummy]::GetDelegate()
} 

write-host "----------------------------------------"


##################################################
# Perform a GET command on the API
Function Get-API
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)] $APICommand
	)

	$temp_url = $global:api_url + $APICommand

	$cmd_splat = @{
		"Method" = "GET";
		"Uri" = $temp_url;
		"Headers" = $global:tokenheader;
		"ContentType" = "application/json";
	}

	if ($global:ps_version -eq 7) {
		$cmd_splat.add("SkipCertificateCheck", $true)
	}

	$api_response = try { 
		Invoke-WebRequest @cmd_splat
	} catch [System.Net.WebException] { 
		Write-Verbose "An exception was caught: $($_.Exception.Message)"
		$_.Exception.Response 
	} 

	return $api_response
}


##################################################
# Perform a POST command on the API
Function Post-API
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)] $APICommand,
		[Parameter(Mandatory = $true)] $JSON_Data
	)

	$temp_url = $api_url + $APICommand

	$cmd_splat = @{
		Method = "POST";
		Uri = $temp_url;
		Headers = $global:tokenheader;
		Body  = $JSON_Data;
		ContentType = "application/json";
	}

	if ($global:ps_version -eq 7) {
		$cmd_splat.add("SkipCertificateCheck", $true)
	}

	$api_response = try { 
		Invoke-WebRequest @cmd_splat
	} catch [System.Net.WebException] { 
		Write-Verbose "An exception was caught: $($_.Exception.Message)"
		$_.Exception.Response 
	} 

	$response_status = [int]$api_response.StatusCode

	if ($response_status -ge 210) {
		Write-Host "Error: Response code = [ " $([int]$api_response.StatusCode) " ]"
		$api_response | Out-String | Write-Host
	}

	return $api_response
}


##################################################
# Function to login and get a generated ASPI key
function Generate-ApiKey {
    # Format the credentials to login as json data
    $json_data = @{
        Username = $global:api_username
        Password = $global:api_password
    } | ConvertTo-Json

    $response = Post-API "/login" $json_data

   # Halt if not receiving a 200 response to login
    if ($response.StatusCode -ne 200) {
        Write-Host "*** ERROR: Response status is [ $($response.StatusCode) ]. Cannot authenticate."
        Write-Host "Halting run -------------------------------------------"
        exit
    }

	# Return just the temp key
    return ($response.Content | ConvertFrom-Json).Key
}

##################################################
# Perform first login to the API
function Login-API {
	Write-Host "Generating temporary API key..."

	# Login and get a temporary key for this session
	$global:api_key = Generate-ApiKey

	Write-Host "Temporary API access key [ $global:api_key ]"
	
	# Change the header used to include the generated key
	$global:tokenheader = @{
		'x-api-key' = $global:api_key
	    'accept' = "application/json"
		'Content-Type' = "application/json"
	} 

	Write-Host "Login to API complete."
	Write-Host "----------------------------------------"
}

<########## Do not change the area above ##########>
<##################################################>
