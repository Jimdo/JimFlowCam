--[[
@title JimKanCam
@param s Seconds 1st shot
@default s 30
@param m Inteval minutes
@default m 30
--]]
require "disk"

sleep_seconds_before_first_shot = s
minutes_to_next_shot = m

while (0 < sleep_seconds_before_first_shot) do
  print("seconds to 1st shot "..sleep_seconds_before_first_shot)
  sleep_seconds_before_first_shot = sleep_seconds_before_first_shot - 1
  sleep(1000)
end

count = 1

while true do
  disk.deleteUntilMbFree(90, 90)
  shoot()
  seconds_to_next_shot = minutes_to_next_shot * 60
  count = count + 1
  while (0 < seconds_to_next_shot) do
    print("seconds to shot #"..count.." "..seconds_to_next_shot)
    seconds_to_next_shot = seconds_to_next_shot - 1
    sleep(1000)
  end
end
