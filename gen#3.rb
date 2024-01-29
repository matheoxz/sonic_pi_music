use_bpm 150

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
  sleep 1
end


with_fx :reverb, room: 1 do
  
  with_fx :wobble, wave: 1, smooth: 1 do
    live_loop :drum do
      part = rrand(0, 100).round
      puts "onset #{part}"
      sample :loop_amen, onset: part, release: 2
      sleep drum_speed
    end
    
    
    with_fx :flanger, wave: 3 do
      live_loop :chords do
        sleep 10 if pause
        pause = false
        ct = direction == -1? 3 : 5
        t = drum_speed * ct
        puts "#time #{t}"
        
        use_synth :bass_foundation
        play chord(scale(:c3, :aeolian).choose, :add13), sustain: t if direction == -1
        
        use_synth :prophet
        play chord(scale(:d2, :aeolian).choose, :add13), sustain: t if direction == 1
        
        sleep t + 1
      end
      
      live_loop :melody do
        ct = direction == -1? 3 : 5
        t = drum_speed * ct
        sleep t
      end
    end
  end
end
