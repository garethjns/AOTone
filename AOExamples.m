%% Generate tone
% Using genTone - see genToneExamples.m for how to use parameters.

% Specify parameters
amp = 0.2;
freq = 800;
dur = 2;
riseDur = 0.02;
Fs = 44100;
phase = 0;

% Generate tone
[tone, tVec, env] = genTone(amp, freq, dur, riseDur, phase, Fs);

% plot
clf
plot(tVec, tone)
hold on
plot(tVec, amp*env)


%% Create audioplayer object
% Creates audiploayer object to handle stimulus and hardware.
% Created with tone passed to L and R channels, and sample rate used to
% generate tone.

ID = -1; % Default device (probably speakers or headphones)
nBits = 24; % Output bits

ao = audioplayer([tone;tone], Fs, nBits, ID);
disp(ao)


%% Play tone
% Calling the play method to output the tone
% This will not block later code from running.

ao.play()
disp('This text is displayed while the output is playing.')


%% Play tone
% Calling the playlBocking method to output the tone
% This will block later code from running.

ao.playblocking()
disp('This text is not displayed until after the output has finished.')