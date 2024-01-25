use_bpm 118
set_volume! 0.7

define :arp_chord do |chord_to_arp, interval: 0.5, amp: 1|
  puts "amp: #{amp}, interval: #{interval}"
  chord_to_arp.length.times do
    puts 'play!'
    play chord_to_arp.tick, amp: amp
    sleep interval
  end
end

with_fx :flanger, wave: 3  do
  
  with_fx :gverb, amp: 0.2 do
    with_fx :nrlpf, cutoff: 100 do
      live_loop :drums do
        sample [:bd_boom, :hat_cats, :sn_generic].choose
        sleep [2, 3, 4, 0.5, 0.25, 1, 0.125, 5].choose
      end
    end
  end
  
  with_fx :nrlpf, cutoff: 40 do
    with_fx :reverb, amp: 0.7 do
      live_loop :bass do
        use_synth :fm
        play (scale :Eb3, :minor_pentatonic).choose
        sleep [1, 1, 2, 0.5].tick
      end
    end
  end
  
  
  live_loop :lead do |a|
    puts a
    if a == 141 and a&.nonzero? then a = 0 end
    sleep 42 if a == 0
    use_synth :hollow
    play (scale :Eb4, :minor_pentatonic).choose, amp: 3 if a < 136
    play (scale :Eb3, :minor_pentatonic).reverse.tick, amp: 3.5 if a > 133
    sleep [1, 1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25].tick if a < 140
    arp_chord (chord :eb, :minor7), interval: 0.5, amp: 3 if a == 140
    inc a
  end
end