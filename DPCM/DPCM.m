clc;
clear all;
close all;
t=0:0.01:1;%time interval of 1 second
a=2;
fc=5;
x=a*sin(2*pi*fc*t);
figure(1)
subplot(3,1,1);
plot(x)
title('x(t) = a.*sin(2*pi*fc*t)');
subplot(3,1,2);
stem(x)
l=zeros(1,100,'int32');
m=zeros(1,100,'int32');
title('Sampled Signal');
[index,quants] = quantiz(x,[0:0.5:4],[0:0.5:4.5]);
for N=1:length(t)
m(N)=x(N);
end
for N=2:99
if m(N-1)<m(N)
l(N)=1;
elseif m(N-1)==m(N)
l(N)=0;
else
l(N)=-1;
end
end
subplot(3,1,3);
stairs(quants);
figure(2)
subplot(3,1,1);
stairs(l)
title('DPCM Quantized Signal');
z1=dec2bin(abs(l));
z2=bin2dec(z1);
subplot(3,1,2)
stem(z2);
title('Dequantized Signal')
[b,a]=butter(2,0.03,'low');
k=filter(b,a,l);
subplot(3,1,3);
plot(k)
title('Reconstructed Signal');