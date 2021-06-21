% Matlab code for Shannon fano coding

% clear and close any other variables and windows.
clc;
close all;
clear all;

% set the probability input

probability_vec = [.5 .25 .125 .125];
probability_vec = probability_vec/sum(probability_vec);

sta=[];
ar=[];
coded=[];
other=[];

first=0;
final=length(probability_vec);
sta = [first final];

% algorithmic logic for shannon fano coding
for f=1:length(probability_vec) %loop for every step
    other=[];
    ar=[];
    for h=1:(length(sta)-1) %loop for each sub-group
        first = sta(h)+1
        final = sta(h+1)
        if(first>=final)
            other=[other; 2]; %when only one element in a sub group
            continue;
        end
        asum=0;
        difmat=[]
        for i=first:final %loop for finding difference vector
            asum=asum+probability_vec(i);
            resum=0;
            for j=i+1:final;    
                resum=resum+probability_vec(j);
            end
            dif=abs(asum-resum);
            difmat=[difmat dif]
        end
        small=min(difmat);
        k=1;
        for i=first:final %loop for finding index of min difference
            if(small==difmat(k))
                break;
            end
            k=k+1;
        end
        index=i
        ar=[ar index]           %storing index in temporary stack
        ind=(index+1)-first     %calulating number of zeros
        remind=final-index      %-and ones for each sub group
        other=[other; zeros(ind,1); ones(remind,1)]
    end
    sta=[ar sta]               %creating final stack for each step
    sta=sort(sta)
    coded=[coded other]        %creating final code word matrix
    if(length(sta)>length(probability_vec))  %break when all sub groups have one element
        break;
    end
end

clc

%display codewords
for index = 1:length(probability_vec)
    codewords{index} = []; % initialize the codewords vector (used to store codewords)
end

len=[];
for i=1:length(probability_vec)
    word=[];
    for(j=1:f)               % 'f' contains max number of bits among codes
        if(coded(i,j)==2)    % break when invalid number(i.e. 2) reached
            break;
        end
        word=[word coded(i,j)];
    end
    len=[len length(word)];
    fprintf('\nSymbol %d code -',i);
    disp(word)
    codewords{i} = word;
end

% Calculation of entropy and average word length
ent=0;
av_length=0;
for i=1:length(probability_vec)
    ent=ent+(probability_vec(i)*log2(1/probability_vec(i)));
    av_length=av_length+len(i)*probability_vec(i);
end

% Calculation of efficiency
eff = (ent/av_length)*100;

% Calculation of variance
variance_val = 0;
for ind = 1:length(codewords)
  variance_val = variance_val + probability_vec(ind) * (length(codewords{ind}) - av_length)^2;
end

disp(['The symbol entropy is: ',num2str(ent)])
disp(['The average shannon fano codeword length is: ',num2str(av_length)])
disp(['The efficiency is: ',num2str(eff)])
disp(['The variance is: ',num2str(variance_val)])
