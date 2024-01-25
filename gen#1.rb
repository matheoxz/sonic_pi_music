use_bpm 118
set_volume! 0.7

###################### Parameters ######################
drums = true
bass = true
lead = true

scale_root = :eb
bass_transpose_octaves = 1
lead_pause = 42
lead_notes_count = 140
########################################################

define :arp_chord do |chord_to_arp, interval: 0.5, amp: 1|
  puts "chord: #{chord_to_arp}, amp: #{amp}, interval: #{interval}"
  chord_to_arp.length.times do
    puts 'play!'
    play chord_to_arp.tick, amp: amp
    sleep interval
  end
end

########################################################

with_fx :flanger, wave: 3 do
  
  with_fx :gverb, amp: 0.2 do
    with_fx :nrlpf, cutoff: 100 do
      live_loop :drums do
        sample [:bd_boom, :hat_cats, :sn_generic].choose if drums
        sleep [2, 3, 4, 0.5, 0.25, 1, 0.125, 5].choose
      end
    end
  end
  
  with_fx :nrlpf, cutoff: 40, amp: 0.5 do
    with_fx :reverb do
      live_loop :bass do
        use_synth :fm
        with_transpose (-12 * bass_transpose_octaves) do
          play (scale scale_root, :minor_pentatonic).choose if bass
          sleep [1, 1, 2, 0.5].tick
        end
      end
    end
  end
  
  
  live_loop :lead do |counter|
    
    puts counter
    if counter == (lead_notes_count+1) and counter&.nonzero? then counter = 0 end
    sleep lead_pause if counter == 0
    
    use_synth :hollow
    play (scale scale_root, :minor_pentatonic).choose, amp: 2 if counter < lead_notes_count and lead
    play (scale scale_root, :minor_pentatonic).reverse.tick, amp: 2.5 if counter > lead_notes_count and lead
    arp_chord (chord scale_root, :minor7), interval: 0.5, amp: 2 if counter == lead_notes_count and lead
    
    sleep [1, 1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25].tick if counter < lead_notes_count
    
    inc counter
  end
end