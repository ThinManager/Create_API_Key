# Create_API_Key README #

Example scripts used to create an API Key to use with ThinManager with specific permissions. The example will output the API key to the PowerShell console. This example works with PowerShell 5 and 7.

The following is an overview of the files included:
- **TM-API-Create-APIKey.ps1** - The main body of code to be executed to generate a ThinManager
API key with specific permissions.
- **TM-API-LIB-config.ps1** - Parameters used for this powershell example. Change the api_url,
api_username, and api_password to match what you have on your system.
- **TM-API-LAB.ps1** - Functions used in the TM-API-Create-APIKey.ps1 script

## Getting Started ##

1. Clone this repository to your local machine.
2. Change the parameters used for this powershell example in the **TM-API-LIB-config.ps1** file. Change the api_url,
api_username, and api_password variables to match what you have on your system.
3. Execute **TM-API-Create-APIKey.ps1** to generate a ThinManager key that will be output to the PowerShell console.

## Disclaimer

Rockwell Automation maintains these repositories as a convenience to you and other users. Rockwell Automation reserves the right at any time and for any reason to refuse access, to edit, or remove content from this Repository. You acknowledge and agree to accept sole responsibility and liability for any Repository content posted, transmitted, downloaded, or used by you. Rockwell Automation has no obligation to monitor or update Repository content

The examples provided are to be used as a reference for building your own application and should not be used in production as-is. It is recommended to adapt the example code based on your project/needs while observing the highest quality and safety standards.

The following list, while not inclusive, are pieces of software that require a paid license or subcription to run in production:
- ThinManager
- ThinManager Logix PinPoint
- FactoryTalk® Optix
- FactoryTalk® View SE
