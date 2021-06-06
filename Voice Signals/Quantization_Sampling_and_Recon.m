clear all;
close all;
close all;
clc;
% Opening the file ...
[m,Fs] = audioread('audio_1.wav');
times=input('Enter times such that fs = times*fm :');
m=resample(m,times,1);
%counting how many samples are there
samples_count = (size(m));
% Calculating maximum value of the input signal 'm(t)'.
Mp = max (m);
% Setting number of bits in a symbol.
bits = input('Enter The number of encoding bits:');
% Defining the number of levels of uniform quantization.
levels = 2^bits;
% Calculating the step size of the quantization.
step_size = (2*Mp)/levels;
%No_ofSamples -> getting all the samples from the file, but for 2seconds max
No_Samples = samples_count(1);
%Creating the time vector -> this shows the sample index so far
time =(1:No_Samples);
% Quantizing the input signal 'm(t)'.
for k = 1:No_Samples,
samp_in(k) = m(k);
quant_in(k) = round(samp_in(k)/step_size(1))*step_size(1);
error(k) = (samp_in(k) - quant_in(k));
end
% Calculating
for k = 1:No_Samples,
reconstructed(k) = quant_in(k)+step_size(1)/2;
end
disp('The requantised sound is ');
pause(.5)
% Plotting the input signal 'm(t)'.
figure;
plot(time/Fs*1000,m(time)); %note that time depends on the sampling frequency
title('Original Signal');
xlabel('Time (ms)');
ylabel('m(t)');
grid on;
% Plotting the quantized signal 'quant_in(t)'.
figure;
subplot(2,1,1)
stem(time/Fs*1000,quant_in(time),'r');
title('Quantized Speech Signal');
xlabel('Time(ms)');
ylabel('Levels');
grid on;
% Plotting the error signal 'error(t)'.
subplot(2,1,2);
plot(time/Fs*1000,error(time));
title('Quantization Error');
xlabel('Time(ms)');
ylabel('Error(t)');
grid on;
% Plotting the reconstructed signal 'error(t)'.
figure
subplot(2,1,1);
plot((time/Fs*1000),reconstructed(time));
title('Reconstructed signal');
xlabel('Time(ms)');
ylabel('r(t)');
grid on;
% Plotting the error signal
%figure;
subplot(2,1,2);
plot(time/Fs*1000,reconstructed(time)-samp_in(time));
title('Error');
xlabel('Time(ms)');
ylabel('PC Signal');
grid on