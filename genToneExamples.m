%% GenTone Examples

%% Simple

amp = 2;
freq = 10;
dur = 1;
riseDur = 0;
Fs = 200;
phase = 0.5;
[tone, tVec] = genTone(amp, freq, dur, riseDur, phase, Fs);

clf
plot(tVec, tone)
ylabel('Amp, V')
xlabel('Time, S')
hold on
scatter(tVec, tone)
%ng

%% Rise/fall

amp = 2;
freq = 8;
dur = 1;
riseDur = 0.5;
Fs = 300;
phase = 0;
[tone, tVec, env] = genTone(amp, freq, dur, riseDur, phase, Fs);

clf
plot(tVec, tone)
hold on
scatter(tVec, tone)
plot(tVec, amp*env)
%ng

%% Realistic

amp = 1;
freq = 800;
dur = 1;
riseDur = 0.02;
Fs = 44100;
phase = 0;
[tone, tVec, env] = genTone(amp, freq, dur, riseDur, phase, Fs);

clf
plot(tVec, tone)
hold on
% scatter(tVec, tone)
plot(tVec, amp*env)
%ng

%% Nyquist
% Constant frequenct, reducing sampling rate.

amp = 2;
freq = 8;
dur = 1;
riseDur = 0.25;
Fs = 300:-1:2;
phase = 0;

for i = Fs

    [tone, tVec, env] = genTone(amp, freq, dur, riseDur, phase, i);
    
    clf
    subplot(2,1,1)
    plot(tVec, tone)
    hold on
    scatter(tVec, tone)
    subplot(2,1,2)
    scatter(env, tone)
    %ng
    drawnow
    
end

%% Multiple tones

amp = [1, 3, 3];
freq = [4, 7, 15];
dur = 0.5;
riseDur = [0.02, 0.03, 0.04];
Fs = 500;
phase = [0, 0.2, 0.6];

nTones = 3;
tones = NaN(3, round(dur*Fs));
for n = 1:nTones
    [tones(n,:), tVec] = genTone(amp(n), freq(n), dur, riseDur(n), phase(n), Fs);
end
comboTone = sum(tones)./nTones;

clf
plot(tVec, tones')
hold on
% plot(tVec, comboTone);
scatter(tVec(1:2:end), comboTone(1:2:end))
%ng

%% Multiple tones

amp = [1, 3, 3];
freq = [4, 7, 15];
dur = 0.5;
riseDur = [0.02, 0.03, 0.04];
Fs = 250;
phase = 0;

for i = 0:0.02:25
    clf
    nTones = 3;
    tones = NaN(3, round(dur*Fs));
    for n = 1:nTones
        [tones(n,:), tVec] = genTone(amp(n), freq(n)+i, dur, ...
            riseDur(n), phase, Fs);
        plot(tVec, tones(n,:))
        hold on
    end
    comboTone = sum(tones)./nTones;
    
    scatter(tVec(1:2:end), comboTone(1:2:end))
    %ng
    
end
%% Multiple tones w/DD freq drift

amp = [1, 3, 3];
freq = [4, 7, 15];
dur = 0.5;
riseDur = [0.02, 0.03, 0.04];
Fs = 250;
phase = 0;

its = 10000;
stim.delta1 = zeros(1,its);
stim.delta2 = zeros(1,its);

params.contPlot = 0;
DDs.DD1 = DD(params,stim);
DDs.DD2 = DD(params,stim);
DDs.DD3 = DD(params,stim);

i = 0;
while DDs.DD1.finished == 0
    clf
    
    i = i + 1;
    
    DDs.DD1 = DDs.DD1.run(1);
    DDs.DD2 = DDs.DD2.run(1);
    DDs.DD3 = DDs.DD3.run(1);
    
    nTones = 3;
    tones = NaN(3, round(dur*Fs));
    
    for n = 1:nTones
        [tones(n,:), tVec] = genTone(amp(n), ...
            freq(n)+DDs.(['DD', num2str(n)]).output(i), ...
            dur, riseDur(n), phase, Fs);
        plot(tVec, tones(n,:))
        hold on
    end
    comboTone = sum(tones)./nTones;
    
    scatter(tVec(1:2:end), comboTone(1:2:end))
    %ng
    drawnow
end

%% Increasing multiple tones

its = 10;
amp = randi(5,1,its);
freq = randi(25,1,its);
dur = 0.5;
riseDur = randi(10,1,its)./100;
Fs = 250;
phase = 0;

tones = zeros(its,(round(dur*Fs)));

for i = 1:its
    clf
    [tones(i,:), tVec] = genTone(amp(i), freq(i), dur, riseDur(i), phase, Fs);
    
    plot(tVec, tones')
    hold on
    comboTone = (sum(tones) + comboTone) ./i;
    
    scatter(tVec(1:2:end), comboTone(1:2:end))
    %ng
    
    pause(0.1)
end
