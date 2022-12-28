# Update-ServicePaths.ps1
 Script to fix unquoted Service Paths
 The Risk
 The remote Windows host contains services installed that use unquoted service paths, which contains at least one whitespace. A local attacker can gain elevated privileges by inserting an executable file in the path of the affected service.

 The Script update-servicepaths.ps1 will fix existing services by adding double quotes around the Path. Script can be distributed to clients using Microsoft Intune