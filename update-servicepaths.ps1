<#
.SYNOPSIS

Fixing Service Paths containing at least one whitespace by surrounding with double quotes .

.DESCRIPTION

Script retrieves Services using get-wmiObject command and updates Path with double quotes

.EXAMPLE
Use Powershell in elevated mode.
.\update-servicepaths.ps1

.LINK
https://github.com/rehle65/Update-ServicePaths.ps1

.NOTES
Version: 1.0
File Name: update-servicepaths.ps1
Author: Roland Ehle, https://github.com/rehle65/Update-ServicePaths.ps1
Requires: Powershell >= 2.0

12/2022 - Initial Version
#>

#Retrieve Services
$services = Get-WMIObject win32_service | where-object {(!($_.Pathname -ilike "*.exe *"))}

#Filter results
$services = $services | where-object {$_.Pathname.Contains(" ")}
$services = $services | where-object {-NOT ($_.pathname.Startswith("`""))}

foreach ($service in $services) {
$scname = $service.name
$scpath = $service.pathname
$newpath = """" + $scpath + """"

Get-WmiObject win32_service -filter "Name='$scname'" | Invoke-WmiMethod -Name Change -ArgumentList @($null,$null,$null,$null,$null,$newpath)
#To remove double quotes use this syntax
#$newpath.Replace("`"","")
}