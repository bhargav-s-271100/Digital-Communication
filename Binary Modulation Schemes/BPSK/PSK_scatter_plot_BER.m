clear all;
z=rand(1,1000);
x=round(z);%generating random signal of 1000 bits
for i=1:length(x)%converting polar waveform
if x(i)==1
xmod(i)=1;
else
xmod(i)=-1;
end
end
scatterplot(xmod);
bersim=[];
for snr=0:2:20;
y=awgn(complex(xmod),snr);%recived signal with white noise introduced
scatterplot(y);
title(sprintf('Scatter Plor for SNR=%d', snr))
for i=1:length(y)%detecting recived signal
if y(i)>=0
det(i)=1;
else
det(i)=0;
end
end
[noe ber]=biterr(x,det)%calling bit error function
bersim=[bersim ber];
end
snr=0:2:20; 
semilogy(snr,bersim,'k*-','linewidth',2);%plotting snr in db with biterror in y
% axis of  log graph
hold on;
grid on;
xlabel('snr')
ylabel('bet_error')

