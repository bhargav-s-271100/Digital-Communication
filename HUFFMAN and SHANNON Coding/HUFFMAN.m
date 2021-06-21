% Matlab code for huffman coding

% clear and close any other variables and windows.
clc;
close all;
clear all;

% set the probability input

probability_vec = [.5 .25 .125 .125];
% probability_vec = [.25 .25 .25 .25];
% probability_vec = [.4 .2 .2 .1 .1];

probability_vec = probability_vec/sum(probability_vec); % as a security step to normalize the probability input

for index = 1:length(probability_vec)
    codewords{index} = []; % initialize the codewords vector (used to store codewords)
    set_contents{index} = index; % useful for backtracing
    set_probabilities(index) = probability_vec(index);
end

% while loop to get the values of codeword
while length(set_contents) > 1
    
    [temp, sorted_indices] = sort(set_probabilities);

    zero_set = set_contents{sorted_indices(1)};
    zero_probability = set_probabilities(sorted_indices(1));
    for codeword_index = 1:length(zero_set)
        codewords{zero_set(codeword_index)} = [codewords{zero_set(codeword_index)}, 0];
    end
    
    one_set = set_contents{sorted_indices(2)};
    one_probability = set_probabilities(sorted_indices(2));
    for codeword_index = 1:length(one_set)
        codewords{one_set(codeword_index)} = [codewords{one_set(codeword_index)}, 1];
    end
    
    set_contents(sorted_indices(1:2)) = [];
    set_contents{length(set_contents)+1} = [zero_set, one_set];
 
    set_probabilities(sorted_indices(1:2)) = [];
    set_probabilities(length(set_probabilities)+1) = zero_probability + one_probability;
    
end

% here since the codewords are reversed, hence reverse is printed
for index = 1:length(codewords)
    disp([num2str(index), ' ', num2str(probability_vec(index)),' ',num2str(codewords{index}(length(codewords{index}):-1:1))]);
end

% codewords are reversed for proper representation
for i=1:length(codewords)
  codewords{i} = fliplr(codewords{i});
end

% Calculation of symbol entropy
entropy = sum(probability_vec.*log2(1./probability_vec));

% Calculation of average Huffman codeword length
av_length = 0;
for index = 1:length(codewords)
    av_length = av_length + probability_vec(index)*length(codewords{index});
end

% Calculation of variance
variance_val = 0;
for ind = 1:length(codewords)
  variance_val = variance_val + probability_vec(ind) * (length(codewords{ind}) - av_length)^2;
end

disp(['The symbol entropy is: ',num2str(entropy)])
disp(['The average Huffman codeword length is: ',num2str(av_length)])
disp(['The efficiency is: ',num2str(entropy/av_length)])
disp(['The variance is: ',num2str(variance_val)])
