clear all;
clc;
close all;
 
z=rand(1,1000);%generating random signal
x=round(z);
%##x = [1 0]
for i=1:2:length(x);
  if x(i:i+1)==[0 0]
    xmod((i+1)/2)=exp(j*pi/4);
  elseif x(i:i+1)==[0 1]
    xmod((i+1)/2)=exp(j*3*pi/4);
  elseif x(i:i+1)==[1 1]
    xmod((i+1)/2)=exp(-j*3*pi/4);
  else
    xmod((i+1)/2)=exp(-j*pi/4);
  end
end
scatterplot(xmod);
bersim=[];
snrs=1:1:10;
for snr=snrs;
  y=awgn(xmod,snr);%recived signal with white noise introduced
  scatterplot(y);
   title(sprintf('Scatter Plor for SNR=%d', snr))
  for i=1:length(xmod);
    theta=angle(y(i));
    if theta>=0 && theta<pi/2
      det(i*2-1:i*2) = [0 0];
    elseif theta>=pi/2 && theta<pi
      det(i*2-1:i*2) = [0 1];
    elseif theta>=-pi && theta<-pi/2
      det(i*2-1:i*2) = [1 1];
    else
      det(i*2-1:i*2) = [1 0];
    end
  end
  [noe ber]=biterr(x,det)%calling bit error function
  bersim=[bersim ber];
end
semilogy(snrs,bersim,'k*-','linewidth',2);%plotting snr in db with biterror in y
% axis of  log graph
hold on;
grid on;
xlabel('snr');
ylabel('bet_error');
