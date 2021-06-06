
clc;
clear all
close all
%Reading the Audio File
y=audioread('audio_1.wav');
y=y(1000:136000);
%  y=y(10000:136000);
%Performing Linear and mu law quantization.
good_quality=uLawCompressor(150,64,y);
bad_quality=linearQuant(64,y);
%Caclulating mean square value of the quantization noise
cost=Error(good_quality,bad_quality,y);
dt=1/48000;
t = 0:dt:(length(y)*dt)-dt;
disp(' mu law linear')
fprintf('Quantization noise %f %f\n',cost(1),cost(2));
%Plots of all signals.
figure(1)
plot(t,y),xlabel('time'),ylabel('Amplitude'),title('Input Signal');
figure(2)
plot(t,good_quality),xlabel('time'),ylabel('Amplitude'),title('mu Law Quantized Signal');
figure(3)
plot(t,bad_quality),xlabel('time'),ylabel('Amplitude'),title('Linear Quantized Signal');
%Calculating the SNR
snrq=SNR(good_quality,bad_quality,y);
fprintf('SNR %f %f\n',snrq(1),snrq(2));
%Writing the audio files.
audiowrite('muLaw.wav',good_quality,48000);
audiowrite('Linear.wav',bad_quality,48000);
%Plot for SNR for differnet values of n.
snrplot1=[];
snrplot2=[];
for j=1:10
good_quality=uLawCompressor(150,2^j,y);
bad_quality=linearQuant(2^j,y);
snrq=SNR(good_quality,bad_quality,y);
snrplot1=[snrplot1 snrq(1)];
snrplot2=[snrplot2 snrq(2)];
end
figure(4)
plot(1:10,snrplot1,'-o'),xlabel('n'),ylabel('SNR'),title('n vs SNR');
hold on
plot(1:10,snrplot2,'-*')
legend('u-law','linear')

