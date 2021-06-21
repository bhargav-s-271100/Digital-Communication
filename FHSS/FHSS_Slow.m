% Slow Frequency Hop Spread Spectrum
clc;
clear all;
close all;

% Generating the data bit pattern
s=round(rand(1,25));

% FSK modulation of carrier by data signal
t1=0:2*pi/9:2*pi;
t2=0:2*pi/39:2*pi;
ca1=cos(t1);
ca2=cos(t2);
signal=[];
carrier=[];
for k=1:25
    if s(1,k)==0
        sig=-ones(1,40); % 10 minus ones for bit 0
        wavef = ca1;
    else
        sig=ones(1,40); % 40 ones for bit 1
        wavef = ca2;
    end
    signal=[signal sig];
    carrier=[carrier wavef];
end
subplot(5,1,1)
plot(signal);
axis([0 1000 -1.5 1.5]);
title('Original Bit Sequence');
subplot(5,1,2);
plot(carrier);
axis([-1 1000 -1.5 1.5]);
title('FSK Modulated signal');

% Preparation of 3 new carrier frequencies
ta1=[0:2*pi/9:2*pi];
ta2=[0:2*pi/39:2*pi];
ta3=[0:2*pi/59:2*pi];
cb1=cos(ta1);
cb2=cos(ta2);
cb3=cos(ta3);
spread_signal=[];
for n=1:25
c = randi([1 3],1,1);
        switch(c)
        case(1)
            spread_signal=[spread_signal cb1];
        case(2)
            spread_signal=[spread_signal cb2];
        case(3)
            spread_signal=[spread_signal cb3];
        end
 end
subplot(5,1,3)
plot(spread_signal);
title('Randomly generated frequencies');
   
% Generation of sum frequency
t1=0:2*pi/19:2*pi;
t2=0:2*pi/49:2*pi;
t3=0:2*pi/69:2*pi;
t4=0:2*pi/79:2*pi;
t5=0:2*pi/99:2*pi;
c1=cos(t1);
c2=cos(t2);
c3=cos(t3);
c4=cos(t4);
c5=cos(t5);
%Generation of transmitted sequence
txsig=[];
for i=1:25
    if (s(1,i)==0) && (c==1)
        txs=c1;
    else if (s(1,i)==0) && (c==2)
        txs=c2;
        else if (s(1,i)==0) && (c==3)
             txs=c3;
                else if (s(1,i)==1) && (c==1)
                     txs=c2;
                    else if (s(1,i)==1) && (c==2)
                         txs=c4;
                        else if (s(1,i)==1) && (c==3)
                             txs=c5;
                        end
                    end
               end
            end
        end
    end
txsig=[txsig txs];
end
subplot(5,1,4)
plot(txsig)
title('Slow frequency hopped signal');

% Power Spectrum Of Slow Frequency hopped signal
power_spectrum=abs(fft(xcorr(txsig)));
subplot(5,1,5)
plot(power_spectrum/max(power_spectrum))
xlabel('Frequency')
ylabel('PSD')
title('Power Spectrum Of Slow Frequency hopped signal');
