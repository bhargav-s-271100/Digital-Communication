clc;
close all;
clear all;

N = 8;
bits = randi([0 1],N,1)

% Slow Hop
chip = randi([1 8],N/2,1)
n = 0:0.0001:1;
tx_fsk = [];
% BFSK Modulator + Mixer
for i=1:N/2
    if bits(2*i-1) == 1
       choice = sin(2*2*chip(i)*pi*n);
    else
       choice = sin(2*(2*chip(i)-1)*pi*n);
    end
    tx_fsk = [tx_fsk choice];
    if bits(2*i) == 1
       choice = sin(2*2*chip(i)*pi*n);
    else
       choice = sin((2*(2*chip(i)-1)*pi*n));
    end
    tx_fsk = [tx_fsk choice];
end

figure("NAME", "Slow frequency hop");

subplot(2,1,1);
stairs(0:1:N-1,bits);
axis([0 N -2 2]);
title("Original signal")

subplot(2,1,2);
plot(0:0.0001:N+(N-1)*0.0001,tx_fsk);
axis([0 N -2 2]);
title("Slow frequency hopped signal")

% Fast Hop
bits_fast_hop = [];
for i = 1:N
   bits_fast_hop = [bits_fast_hop [bits(i) bits(i)]]; % original signal is expanded
end
chip = randi([1 4],2*N,1);
tx_fsk_fast_hop = [];
% BFSK Modulator + Mixer
for i=1:2*N
    if bits_fast_hop(i) == 1
       choice = sin(2*2*chip(i)*pi*n);
    else
       choice = sin(2*(2*chip(i)-1)*pi*n);
    end
    tx_fsk_fast_hop = [tx_fsk_fast_hop choice];
end

figure("NAME", "Fast frequency hop");

subplot(2,1,1);
stairs(0:1:2*N-1,bits_fast_hop); % expanded original signal is plotted
axis([0 2*N -2 2]);
title("Original signal")

subplot(2,1,2);
plot(0:0.0001:2*N+(2*N-1)*0.0001,tx_fsk_fast_hop);
axis([0 2*N -2 2]);
title("Fast frequency hopped signal")
