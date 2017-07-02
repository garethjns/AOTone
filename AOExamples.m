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
% Created with tone passed to L and R channels, and sample rate used to
% generate tone.

ao = audioplayer([tone;tone], Fs);
disp(ao)


%% Play tone
% Calling the play method output the tone

ao.play()
