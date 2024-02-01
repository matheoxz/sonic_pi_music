use_bpm 150
use_osc "localhost", 12000

drum_speed = 0.5
direction = 1
drum_increment = 0.001
pause = true

live_loop :drum_speed do
  
  if drum_speed <= 0.4 or drum_speed >= 0.5 then
    direction *= -1
    pause = true
  end
  
  drum_speed += drum_increment * direction
  
  puts "drum speed #{drum_speed}"
  osc "/direction", direction
  osc "/speed", drum_speed
  sleep 0.25
end


with_fx :reverb, room: 1 do
  
  with_fx :wobble, wave: 3, smooth: 5 do
    live_loop :drum do
      part = rrand(0, 100).round
      puts "onset #{part}"
      osc "/drum", part
      sample :loop_amen, onset: part, release: 2
      sleep drum_speed
    end
  end
end
