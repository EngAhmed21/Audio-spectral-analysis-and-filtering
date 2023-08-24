% MATLAB code for audio analysis and filtering
%% Clear section
clear
clc
close all
%% Read the audio
% audioread is used to import the audio file and return a sample rate for that data, Fs.
[audio, fs] = audioread("audio.wav");
% length is used to get the length of the sampled data of the audio file
N_original = length(audio);
%% Plot the magnitude spectrum of the original audio 
figure
% fft returns the n-point discrete Fourier transform (DFT).
X = fft(audio, N_original);
% Shifting the spectrum to be centered around zero
F_original = (-N_original/2 : N_original/2 - 1) * fs/N_original;
% Plotting the magnitude spectrum
plot(F_original, abs(fftshift(X))/N_original);
xlabel('Frequency(Hz)');
ylabel('|X|');
title("The magnitude spectrum of the original audio");
%% Filtering the audio using lowpass filter
% Loading the filter
load('Filter.mat');
% Filtering the audio
filteredAudio = filter(Hd, audio);
%% Save the filtered audio and play it
filename ='filtered.wav';
% Saving the filtered audio
audiowrite(filename,filteredAudio,fs);
% Playing the filtered audio
sound(filteredAudio,fs);
%% Plot the magnitude spectrum of the filtered audio
figure
% Getting the length of the sampled filtered audio
N_filtered = length(filteredAudio);
% Getting the DFT of the filtered audio
Y = fft(filteredAudio, N_filtered);
% Shifting the spectrum to be centered around zero
F_filtered = (-N_filtered/2 : N_filtered/2 -1) * fs/N_filtered;
% Plotting the magnitude spectrum of the filtered audio
plot(F_filtered, abs(fftshift(Y))/N_filtered);
xlabel('Frequency(Hz)');
ylabel('|Y|');
title("The magnitude spectrum of the filtered audio ");
%% The frequency response of the filter
freqz(Hd);
%% The impulse response of the filter
impz(Hd);
%% Plot the magnitude spectrum of the filtered audio at twice the speed
figure
% Doupling the speed of the filtered audio
filteredAudio2 = resample(filteredAudio, 1, 2);
% Getting the length of the audio
N2_filtered= length(filteredAudio2);
% Getting the DFT
Y2 = fft(filteredAudio2, N2_filtered);
% Shifting the spectrum to be centered around zero
F2_filtered = (-N2_filtered/2 : N2_filtered/2 - 1)*fs/N2_filtered;
% Plotting the magnitude spectrum of the filtered audio at twice the speed
plot(F2_filtered,abs(fftshift(Y2))/N2_filtered)
xlabel('frequency (Hz)');
ylabel('|Y2|');
title("The magnitude spectrum of the filtered audio at twice the speed");
