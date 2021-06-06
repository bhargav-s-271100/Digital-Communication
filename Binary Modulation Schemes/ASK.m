clc;
clear all;
close all;

x=randi(1, 10); % Bin data
bp=0.000001; % bit period
t1=0:bp:length(x)*bp;

subplot(3,1,1);
stairs(t1, [x, x(end)], 'LineWidth', 2);
grid on;
ylabel('Amplitude');
xlabel(' time(sec)');
axis([0 t1(end) -.5 1.5]);
title('Input digital signal');

%Modulation
a1=10; % Amplitude of carrier signal for information 1
a0=0; % Amplitude of carrier signal for information 0
br=1/bp; % bit rate
f=br*10; % carrier frequency 
t2=0:bp/100:bp*0.99;                 
ss=length(t2);

m=[];
for (i=1:1:length(x))
  if (x(i)==1)
    y=a1*cos(2*pi*f*t2);
  else
    y=a0*cos(2*pi*f*t2);
  end
  m=[m y];
end
t3=0:bp/100:bp*(length(x)-0.01);
subplot(3,1,2);
plot(t3,m);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('ASK modulated wave');

%Demodulation
mn=[];
for n=ss:ss:length(m);
  t=0:bp/100:bp*0.99;
  y=cos(2*pi*f*t); % carrier siignal 
  mm=y.*m((n-(ss-1)):n);
  t4=0:bp/100:bp*0.99;
  z=trapz(t4,mm); % intregation 
  zz=round((2*z/bp));                                     
  if(zz>(a1+a0)/2)
    a=1;
  else
    a=0;
  end
  mn=[mn a];
end

bit=[];
for n=1:length(mn);
  if mn(n)==1
    se=ones(1,100);
  else
    se=zeros(1,100);
  end
  bit=[bit se];
end
t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3);
plot(t4,bit,'LineWidth',2.5);
grid on;
axis([ 0 bp*length(mn) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Output digital signal');

scatterplot(x);
xlim([-1.2 1.2]);
ylim([-1.2 1.2]);
grid on;
