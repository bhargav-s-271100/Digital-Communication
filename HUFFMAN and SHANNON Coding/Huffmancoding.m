clc
p= input('Enter the probabilities of the symbols:');
n=length(p);
symbols=[1:n];
[dict,avglen]=huffmandict(symbols,p);
temp=dict;
t=dict(:,2);
for i=1:length(temp)
    temp{i,2}=num2str(temp{i,2});
end
disp('The Huffman Code Dictionary is:');
disp(temp);
fprintf('Enter the symbols between 1 to %d in[]',n);
sym=input(':')
encod=huffmanenco(sym,dict);
disp('The encoded output:');
disp(encod);
bits=input("Enter the bit stream in []:");
decod=huffmandeco(bits,dict);
disp(decod);
H=0;
Z=0;
for(k=1:n)
    H=H+(p(k)*log2(1/p(k)));
end
fprintf(1,'Entropy of %f bits per symbol',H);
N=H/avglen;
fprintf("\n Efficiency is %f",N);
for(r=1:n)
    l(r)=length(t(r));
end
m=max(l)
s=min(l)
v=m-s;
fprintf("\n Variance is %d",v);
N