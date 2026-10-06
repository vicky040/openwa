# Usage: $env:OPENWA_API_KEY="..."; ./send-template.ps1 -SessionId <id> -To 919876543210 -Customer Rahul -Amount "₹1,500" -OrderId INV-1042 -Method UPI
param(
  [Parameter(Mandatory)] [string]$SessionId,
  [Parameter(Mandatory)] [string]$To,
  [Parameter(Mandatory)] [string]$Customer,
  [Parameter(Mandatory)] [string]$Amount,
  [Parameter(Mandatory)] [string]$OrderId,
  [string]$Method = "UPI",
  [string]$BaseUrl = "http://localhost:2785"
)
if (-not $env:OPENWA_API_KEY) { throw "Set OPENWA_API_KEY first" }
$body = @{
  chatId = "$To@c.us"
  templateName = "payment-received"
  vars = @{ customer=$Customer; amount=$Amount; orderId=$OrderId; date=(Get-Date -Format "dd MMM yyyy"); method=$Method }
} | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri "$BaseUrl/api/sessions/$SessionId/messages/send-template" `
  -Headers @{ "X-API-Key" = $env:OPENWA_API_KEY } -ContentType "application/json; charset=utf-8" -Body ([Text.Encoding]::UTF8.GetBytes($body))
