% non-uniform quantization : A law companding
clc;
clear all;
close all;
% when A=1, no compression occurs and input=output
% when A is more,compression is more
x=0:0.01:1; %range of x is from 0 to 1 with step size=0.20
a=[1 2 87.56]; %A values considered for evaluation
for i=1:length(a)
    for j=1:length(x)
        if x(j)>=0&&x(j)<=(1/a(i))
            y(i,j)=(a(i)*x(j))/(1+log(a(i)));
        elseif x(j)>(1/a(i))&&x(j)<=1
            y(i,j)=(1+log(a(i)*x(j)))/(1+log(a(i)));
        end
    end
end
plot(x,y(1,:),'r','linewidth',1.5);
hold on;
plot(x,y(2,:),'g','linewidth',1.5);
plot(x,y(3,:),'b','linewidth',1.5);
grid on;
legend('A=0','A=5','A=255','location','southeast');
xlabel('Normalized input');
ylabel('Normalized output');
title('A law companding');