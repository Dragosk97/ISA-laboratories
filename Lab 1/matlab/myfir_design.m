function [bi, bi7, bq, bq7]=myfir_design(N,nb)
%% function myfir_design(N,nb)
%% N is order of the filter
%% nb is the number of bits
%% bi taps represented as integers

close all;

f_cut_off = 2000; % 2kHz
f_sampling = 10000; % 10kHz

f_nyq = f_sampling/2; %% Nyquist frequency
f0 = f_cut_off/f_nyq; %% normalized cut-off frequency

b=fir1(N, f0); %% get filter coefficients
[h1, w1]=freqz(b); %% get the transfer function of the designed filter

bi=floor(b*2^(nb-1)); %% convert coefficients into nb-bit integers
bq=bi/2^(nb-1); %% convert back coefficients as nb-bit real values
[h2, w2]=freqz(bq); %% get the transfer function of the quantized filter

bi7=floor(b*2^(nb-2)); %% convert coefficients into nb-bit integers
bq7=bi7/2^(nb-2); %% convert back coefficients as nb-bit real values
[h3, w3]=freqz(bq7); %% get the transfer function of the quantized filter

%% show the transfer functions
plot(w1/pi, 20*log10(abs(h1))); 
hold on;
plot(w2/pi, 20*log10(abs(h2)),'r--');
hold on;
plot(w3/pi, 20*log10(abs(h3)),'g-.');
grid on;
xlabel('Normalized frequency');
ylabel('dB');

legend ('Transfer function of the designed filter', 'Transfer function of the 8-bit quantized filter', 'Transfer function of the 7-bit quantized filter');



