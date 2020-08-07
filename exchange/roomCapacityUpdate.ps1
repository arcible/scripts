$capacityFactor = [int]2
$rooms = Get-Mailbox -RecipientTypeDetails RoomMailbox

Write-Host -ForegroundColor Yellow "The capacity factor is set to $capacityFactor. All rooms will have their capacity divided by this number."

ForEach ($room in $rooms) {
  $roomCount = $roomCount+1
  Write-Progress -Activity "Setting New Room Capacity" -Status "Progress:" -PercentComplete ($roomCount/$rooms.Count*100)

  Write-Host "Room $($room.Name) capacity will be changed from $($room.ResourceCapacity) to $newCapacity."

  $newCapacity = [int][Math]::Ceiling($room.ResourceCapacity / $capacityFactor)
  Set-Mailbox -Identity $room.Identity -ResourceCapacity $newCapacity
}
