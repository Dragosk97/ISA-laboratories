clear all
close all
Nbit = 24;
%100 random numbers from 0 to 1
a_rand = rand(1,100); 
b_rand = rand(1,100);

% bring the 100 numbers to binary numbers
a = floor(2^Nbit*a_rand); 
b = floor(2^Nbit*b_rand);
product = a.* b;
% conversion of the numbers from decimal to binary
a_binary = dec2bin(a,Nbit);
b_binary = dec2bin(b,Nbit);
p_binary = dec2bin(product, 2*Nbit);

fileID = fopen('input_file.txt','w');
for ii = 1: 100
fprintf(fileID,'%24s %24s\n', a_binary(ii,:), b_binary(ii,:));
end
fclose(fileID);

fileID = fopen('result_file.txt','w');
for ii = 1: 100
fprintf(fileID,'%48s\n', p_binary(ii,:));
end
fclose(fileID);
