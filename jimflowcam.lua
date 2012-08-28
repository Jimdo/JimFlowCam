--[[

Copyright (C) [2012]  [Jimdo GmbH - Michael Lehr]

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.

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
