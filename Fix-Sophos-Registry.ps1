$idRef = [System.Security.Principal.NTAccount]("NT AUTHORITY\LOCAL SERVICE")
$regRights = [System.Security.AccessControl.RegistryRights]::FullControl
$inhFlags = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit
$prFlags = [System.Security.AccessControl.PropagationFlags]::None
$acType = [System.Security.AccessControl.AccessControlType]::Allow
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ($idRef, $regRights, $inhFlags, $prFlags, $acType)
$acl.AddAccessRule($rule)
$acl | Set-Acl -Path 'Registry::HKEY_USERS\S-1-5-19\SOFTWARE\Microsoft\SystemCertificates'