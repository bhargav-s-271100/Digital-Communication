% non-uniform quantization : u law companding
clc;
clear all;
close all;
x=0:0.01:1; %range of x is from 0 to1 with step size=0.1
mu=[0 5 25 255];%u values considered for evaluation
%when u=0, there is no compression (input = output)
% more the value of u, more is the compression
for i=1:length(mu)
    for j=1:length(x)
    	if mu(i)==0
            y(i,j)=x(j);
        else
            y(i,j)=log(1+(mu(i)*x(j)))/log(1+mu(i));
        end
    end
end
plot(x,y(1,:),'r','linewidth',1.5);
hold on;
plot(x,y(2,:),'g','linewidth',1.5);
plot(x,y(3,:),'b','linewidth',1.5);
plot(x,y(4,:),'y','linewidth',1.5);
legend('\mu=0','\mu=5','\mu=25','\mu=255','location','southeast');
xlabel('Normalized input');
ylabel('Normalized output');
title('u law companding');