%% Adaline: Audio filter
clc; clear;

% We load the audio and save the data in a variable "s" and the sample rate
% in the variable "fs".
[s, fs] = audioread('D:\Documentos\MATLAB\Sis. Inteligentes III\Scherzo.mp3'); 

tiempo = size(s,1)/fs; % Time variable
x = 0:1/fs:tiempo; % X Axis to plot
an = awgn(s,1,'measured','linear'); % Adds Noise to the audio
w = [rand(1); rand(1)]; % Initilized weights
G = 10; % Generations
alfa = 0.1; % Learning factor
L = length(an);

for i = 1:G
    for j = 1:L
        ann = [an(j,1), an(j,2)]; % Preparing inputs
        ss(j) = ann*w; % output
        e = s(j,1)- ss(j); % Error
        w = w + alfa*e*ann'; % weights update
    end
end

figure()
subplot(3,1,1), plot(x(2:end),s), xlim([0 tiempo]),title('Original (s)') %Original Audio
subplot(3,1,2), plot(x(2:end),an), xlim([0 tiempo]),title('Ruido (an)') % Audio with noise
subplot(3,1,3), plot(x(2:end),ss), xlim([0 tiempo]),title('Filtrada (ss)') % Audio Filtered

pause()
sound(an,fs)
pause()
sound(ss,fs)