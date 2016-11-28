param (
  [Parameter(Mandatory=$true)]
  [string]$vmName,
  [Parameter(Mandatory=$true)]
  [string]$publishSettingsFile
)
write-host "this script sort of assumes you've run the agent MSI yourself," -f yellow -b black
write-host "AND that you've dropped the file you got from running" -f yellow -b black
write-host "Get-AzurePublishSettingsFile in this directory." -f yellow -b black

push-location
Import-AzurePublishSettingsFile $publishSettingsFile
Select-AzureSubscription -SubscriptionId "e89e34ab-4cb2-40e7-b374-5ec0a4b9c57d" -Default
$vm = get-azurevm -ServiceName $key -Name $key
Update-AzureVM -Name $vm.Name -VM $vm.VM -ServiceName $vm.ServiceName
Get-AzureVM -ServiceName $key -Name $key
