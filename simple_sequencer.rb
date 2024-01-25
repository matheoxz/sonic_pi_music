# LIVE MIXER (0 = mute, 1 = channel on)
###################### MIXER ######################
kickon  = 1
hihaton = 1
rimon   = 1

###################################################
live_loop :metronome do
  sleep 1
end

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end
###################################################
live_loop :kick, sync: :metronome do
  with_swing -0.08, 2 do
    sample :bd_tek, rate: 0.8, sustain: 0, release: 0.3, amp: 0.8 if pattern "x---x---x---x---" and kickon == 1
  end
  sleep 0.25
end

live_loop :kick_soft, sync: :metronome do
  with_swing -0.08, 2 do
    sample :bd_tek, rate: 0.7, sustain: 0, release: 0.2, amp: 0.2 if pattern "---------------x---------x------" and kickon == 1
  end
  sleep 0.25
end

live_loop :hh, sync: :metronome do
  with_swing -0.08, 2 do
    sample :drum_cymbal_closed, sustain: 0, release: 0.15, amp: 0.8, rate: 1.1 if pattern "--x---x---x---x-" and hihaton == 1
  end
  sleep 0.25
end

live_loop :hh_short, sync: :metronome do
  with_swing -0.08, 2 do
    sample :drum_cymbal_pedal, sustain: 0, release: 0.05, pan: -0.4, amp: 0.3, start: 0.1 if pattern "--xx--x--xx--x-x" and hihaton == 1
  end
  sleep 0.25
end


with_fx :reverb, damp: 1, mix: 0.3 do
  live_loop :rimshot, sync: :metronome do
    with_swing -0.08, 2 do
      sample :sn_generic, amp: 0.4, sustain: 0, release: 0.10 if pattern "----x-------x---" and rimon == 1
    end
    sleep 0.25
  end
end

live_loop :rimshot2, sync: :metronome do
  with_swing -0.08, 2 do
    sample :elec_filt_snare, sustain: 0, release: 0.10, pan: 0.4, rate: 0.5, amp: 0.2 if pattern "----x--x----x-------x--x-x--x---" and rimon == 1
  end
  sleep 0.25
end