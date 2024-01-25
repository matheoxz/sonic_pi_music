use_bpm 118
set_volume! 0.7
#################################
intervals = [1, 3, 2, 2, 0.5, 0.5, 3]
melody_times = 5
#################################

with_fx :eq, low_shelf: -1, high_shelf: -1, high_shelf_note: 80, high_q: 0.5 do
  with_fx :reverb, mix: 0.9, room: 0.9, damp: 0.9 do
    
    with_fx :ping_pong, phase: 1 do
      live_loop :chords do
        use_synth :prophet
        play chord(choose([:d2, :g1]), :minor), release: 4, cutoff: rrand(70, 130)
        sleep 4
      end
      
      live_loop :kick do
        sample :bd_808, rate: 0.5
        sleep 2
      end
    end
    
    with_fx :normaliser, level: 0.5, amp: 0.5 do
      with_fx :flanger do
        live_loop :melody do
          puts "sleep melody: #{intervals.sum}"
          sleep intervals.sum
          
          (intervals.count * melody_times).times do |i|
            puts "play melody #{(i/intervals.count).round + 1} time"
            use_synth :sine
            interval = intervals.tick
            puts "play note for #{interval}"
            play (scale :g4, :minor_pentatonic).choose, sustain: interval/2, release: interval/2, attack: 0, attack_level: 0.1, sustain_level: 0.2
            sleep interval
          end
        end
      end
    end
  end
end