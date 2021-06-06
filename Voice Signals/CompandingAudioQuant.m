clear all;
close all; 
clc;

%Sound File 1
[y,Fs] = audioread('audio_1.wav');    %Random audio file
%info = audioinfo('AUD-20210531-WA0007.aac');       %Information about the audio

y = exp(18*y);
%Time Domain Analysis
ft = y(:,1);
sigLength = length(ft); %length
 t=(0:sigLength-1)/(Fs);                             %Time index adjustment
%%%%Plot
figure(1); subplot(2,1,1); plot(t,y);
xlabel('Time'); ylabel('Original Audio Signal')
%sound(y,Fs);
%keyboard

L = 15;                     %Quantization Levels are 16 but index 0:15
V= max(y);

%%%%%Linear Quantization
[index,quants,distor_linear] = quantiz(y,multithresh(y,L), [multithresh(y,L) V]);
%%%%Plot
subplot(2,1,2); plot(t,quants);
xlabel('Time'); ylabel('Linear Quatized Audio Signal')
% sound(quants,Fs); 

%%%%% Non-linear Quantization/Companding
law_param = 255;   %Kept same for mu/A - law

%%%%% Mu law
compressed_mu = compand(y,law_param,max(y),'mu/compressor');
[index_mu,quants_mu,distor_mu] = quantiz(compressed_mu,multithresh(y,L), [multithresh(y,L) V]);
expanded_mu = compand(quants_mu,law_param,max(quants_mu),'mu/expander');
figure(2); subplot(2,1,1); plot(t,expanded_mu);
xlabel('Time'); ylabel('mu-law Quatized Audio Signal')
%sound(expanded_mu,Fs);
%keyboard

%%%%% A-law
compressed_A = compand(y,law_param,max(y),'A/compressor');
[index_A,quants_A,distor_A] = quantiz(compressed_A,multithresh(y,L), [multithresh(y,L) V]);
expanded_A = compand(quants_A,law_param,max(quants_A),'A/expander');
figure(2); subplot(2,1,2); plot(t,expanded_A);
xlabel('Time'); ylabel('A-law Quatized Audio Signal')
%sound(expanded_A,Fs);

%%%%%Comparison of the Schemes
distor_linear_quant =distor_linear
distor_mu_law = sum((expanded_mu'-y).^2)/length(y)
distor_A_law =sum((expanded_A'-y).^2)/length(y)