#!ps
$npus = Get-PnpDevice | Where-Object {
    ($_.Class -eq 'Processor' -or $_.Class -eq 'Display' -or $_.Class -eq 'ComputeAccelerator') -and (
    ($_.FriendlyName -match 'NPU') -or
    ($_.FriendlyName -match 'Neural Processor') -or
    ($_.FriendlyName -match 'Intel AI Boost') -or
    ($_.FriendlyName -match 'AMD IPU Device') -or
    ($_.Class -eq 'NeuralProcessors'))
}

if ($npus) {
    Return 1
} else {
    Return 0
}