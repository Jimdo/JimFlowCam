--[[
@title JimFlowCam
@param s Seconds 1st shot
@default s 30
@param m Inteval minutes
@default m 30
--]]
require "disk"

sleep_seconds_before_first_shot = s
minutes_to_next_shot = m
mb_min = n
mb_target = x

while (0 < sleep_seconds_before_first_shot) do
  print("seconds to 1st shot "..sleep_seconds_before_first_shot)
  sleep_seconds_before_first_shot = sleep_seconds_before_first_shot - 1
  sleep(1000)
end

count = 1

while true do
  local imageList = disk.filterImageFiles("IMG")
  local fileCount = table.getn(imageList)
  local i = 0
  while i ~= fileCount do
    i = i + 1
    os.remove(imageList[i])
  end
  shoot()
  seconds_to_next_shot = minutes_to_next_shot * 60
  count = count + 1
  while (0 < seconds_to_next_shot) do
    print("seconds to shot #"..count.." "..seconds_to_next_shot)
    seconds_to_next_shot = seconds_to_next_shot - 1
    sleep(1000)
  end

  if (count % 10 == 0) then
    poke(0xC0220018,0x44)
    sleep(1000)	
    poke(0xC0220018,0x46)
    sleep(5000)
  end
end
