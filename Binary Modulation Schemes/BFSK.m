clc;
clear all;
close all;

x=randint(1, 10); % Bin data
N=length(x);                     
Tb=0.0001; % bit period (second)   
t1=0:Tb:N*Tb; % time of the signal 
figure(1);
subplot(3,1,1);
stairs(t1,[x, x(end)],'lineWidth',2);grid on;
axis([ 0 Tb*N -0.5 1.5]);
ylabel('Tmplitude(volt)');
xlabel(' Time(sec)');
title('Input digital signal');

# Modulation
Ac=5;  % Amplitude of carrier signal
mc1=4;  % fc>>fs fc=mc*fs fs=1/Tb
mc0=2;
fc1=mc1*(1/Tb); % carrier frequency for bit 1
fc0=mc0*(1/Tb); % carrier frequency for bit 0
t2=0:Tb/100:Tb*0.99;                 
t2L=length(t2);
y=[];
for (i=1:1:N)
  if (x(i)==1)
      y1=Ac*cos(2*pi*fc1*t2);%modulation signal with carrier signal 1
  else
      y1=Ac*cos(2*pi*fc0*t2);%modulation signal with carrier signal 2
  end
  y=[y y1];
end
t3=0:Tb/100:Tb*(N-0.01);
subplot(3,1,2);
plot(t3,y);
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Signal of  BASK modulation ');

# Channel model h and w
h=1; % Fading 
w=0; % Noise
y=h.*y+w;

# Demodulation 
z=[];
for n=t2L:t2L:length(y)
  t=0:Tb/100:Tb*0.99;
  c_dem1=cos(2*pi*fc1*t); % carrier signal for information 1
  c_dem0=cos(2*pi*fc0*t); % carrier signal for information 0
  y_dem1=c_dem1.*y((n-(t2L-1)):n);
  y_dem0=c_dem0.*y((n-(t2L-1)):n);
  t4=0:Tb/100:Tb*0.99;
  z1=trapz(t4,y_dem1);  % intregation 
  z0=trapz(t4,y_dem0);  % intregation 
  A_dem1 = round(2*z1/Tb);
  A_dem0 = round(2*z0/Tb);
  if(A_dem1>Ac/2)      % % logic level = (Ac)/2
    z=[z 1];
  else
    z=[z 0];
  end
end

subplot(3,1,3);
stairs(t1,[z, z(end)],'lineWidth',2);grid on;
axis([ 0 Tb*N -0.5 1.5]);
ylabel('Amplitude(volt)');
xlabel(' Time(sec)');
title('Output digital signal');

xmod=x;
xmod(x==0)=j;
scatterplot(xmod);
xlim([-1.2 1.2]);
ylim([-1.2 1.2]);
grid on;
