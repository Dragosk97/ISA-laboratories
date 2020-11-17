clear all;

fs=10000; %% sampling frequency
f1=500;  %% first sinewave freq (in band)
f2=4500; %% second sinnewave freq (out band)

N=8; %% filter order
nb=8; %% number of bits

T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples

x1=sin(2*pi*f1*tt); %% first sinewave
x2=sin(2*pi*f2*tt); %% second sinewave

x=(x1+x2)/2; %% input signal

[bi, bi7, bq, bq7]=myfir_design(N, nb); %% filter design

y=filter(bq, 1, x); %% apply filter
y7 = filter(bq7, 1, x);
%% plots
figure
plot(tt,x1,'--d');
hold on
plot(tt,x2,'r--s');
plot(tt,x, 'g--+');
plot(tt, y, 'c--o');

legend('x1', 'x2', 'x', 'y')

%% quantize input and output
xq=floor(x*2^(nb-1));
idx=find(xq==2^(nb-1));
xq(idx)=2^(nb-1)-1;

yq=floor(y*2^(nb-1));
idy=find(yq==2^(nb-1));
yq(idy)=2^(nb-1)-1;

yq7 = floor(y7*2^(nb-2));
idy7=find(yq7==2^(nb-2));
yq7(idy)=2^(nb-2)-1;

yq7 = 2*yq7;
%% save input and output
fp=fopen('samples.txt','w');
fprintf(fp,'%d\n', xq);
fclose(fp); 

fp=fopen('resultsm.txt', 'w');
fprintf(fp, '%d\n', yq);
fclose(fp);

fp=fopen('output_c_7.txt', 'r');
y_C = fscanf(fp, '%d');

%% Computation of the Total Harmonic Distortion 
figure(3)
subplot(1,2,1)
thd(yq7)
subplot(1,2,2)
thd(y_C)

figure
plot(tt,yq7/2,tt,y_C/2);
ylabel('Amplitude of 8 bits')
xlabel('Time / ms')
legend('output of Matlab','output of the C program')

fclose(fp);