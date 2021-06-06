% QPSK Modulation and Demodulation
clc;
clear all;
close all;

x=randint(1, 20); % Bin data
N=length(x);                     
br=10.^6; %Let us transmission bit rate
f=br; % minimum carrier frequency
T=1/br; % bit duration 
t1 = 0:T:N*T; % time of the signal 
figure(1);
subplot(5,1,1);
stairs(t1,[x, x(end)],'lineWidth',2);
grid on;
axis([ 0 T*N -0.5 1.5]);
ylabel('Tmplitude(volt)');
xlabel(' Time(sec)');
title('Input digital signal');

x_NZR=2*x-1; % Data Represented at NZR form for QPSK modulation
s_p_x=reshape(x_NZR,2,length(x)/2);  % S/P convertion of data

##t=T/99:T/99:T; % Time vector for one bit information
t=0:T/100:T*0.99;                 
% Modulation
y=[];
y_in=[];
y_qd=[];
for(i=1:length(x)/2)
  y1=s_p_x(1,i)*cos(2*pi*f*t); % inphase component
  y2=s_p_x(2,i)*sin(2*pi*f*t) ;% Quadrature component
  y_in=[y_in y1]; % inphase signal vector
  y_qd=[y_qd y2]; %quadrature signal vector
  y=[y y1+y2]; % modulated signal vector
end
Tx_sig=y; % transmitting signal after modulation
tt=(0:T/50:(T*length(x)))(1:end-1); 

subplot(5,1,2);
plot(tt,y_in,'linewidth',2), 
grid on;
title('Inphase component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
subplot(5,1,3);
plot(tt,y_qd,'linewidth',2), 
grid on;
title('Quadrature component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
subplot(5,1,4);
plot(tt,Tx_sig,'r','linewidth',2), 
grid on;
title('QPSK modulated signal (sum of Inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel(' amplitude(volt)');

% Demodulation
Rx_x=[];
Rx_sig=Tx_sig; % Received signal
for(i=1:1:length(x)/2)
  %% Inphase coherent dector
  Z_in=Rx_sig((i-1)*length(t)+1:i*length(t)).*cos(2*pi*f*t); 
  % above line indicat multiplication of received & inphase carred signal
  
  Z_in_intg=(trapz(t,Z_in))*(2/T);% integration using trapizodial rull
  if(Z_in_intg>0) % Decession Maker
    Rx_in_x=1;
  else
    Rx_in_x=0; 
  end
  
  %% Quadrature coherent dector 
  Z_qd=Rx_sig((i-1)*length(t)+1:i*length(t)).*sin(2*pi*f*t);
  %above line indicat multiplication ofreceived & Quadphase carred signal
  
  Z_qd_intg=(trapz(t,Z_qd))*(2/T);%integration using trapizodial rull
  if (Z_qd_intg>0)% Decession Maker
    Rx_qd_x=1;
  else
    Rx_qd_x=0; 
  end
            
  Rx_x=[Rx_x  Rx_in_x  Rx_qd_x]; % Received Data vector
end
subplot(5,1,5);
stairs(t1,[x, x(end)],'lineWidth',2);
grid on;
axis([ 0 T*N -0.5 1.5]);
ylabel('Tmplitude(volt)');
xlabel(' Time(sec)');
title('Output digital signal');

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
xlim([-1.2 1.2]);
ylim([-1.2 1.2]);
grid on;
