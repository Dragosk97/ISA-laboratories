clear all
close all

N = 6;

x = categorical({'Behaviour', 'CSA', 'PPARCH',  'beh\_opt', 'beh\_ultra', 'MBE', 'MBE\_opt', 'MBE\_ultra'});
behaviour = [1.56 4.0477];
CSA = [4.3 4.8614];
PPARCH = [1.59 4.0111];
beh_opt = [0.78 5.1806];
beh_ultra = [1.5 4.1985];
MBE = [2.78 4.6478];
MBE_opt = [0.79 6.9655];
MBE_ultra = [1.46 4.8459];
% P_behaviour = behaviour(1)*behaviour(2);
% P_CSA =  CSA(1)*CSA(2);
% P_PPARCH =  PPARCH(1)*PPARCH (2);
% P_beh_opt = beh_opt(1)*beh_opt(2);
% P_beh_ultra = beh_ultra(1)*beh_ultra(2);
% P_MBE =  MBE(1)*MBE(2);
% P_MBE_opt = MBE_opt(1)*MBE_opt(2);
% P_MBE_ultra = MBE_ultra(1)*MBE_ultra(2);
% y = [behaviour; CSA; PPARCH; beh_opt; beh_ultra; MBE; MBE_opt; MBE_ultra];
y(:,1) = y(:,1) / min(y(:,1));
y(:,2) = y(:,2) / min(y(:,2));
y(:,3) = y(:,1).*y(:,2);
y_P = [P_behaviour; P_CSA; P_PPARCH; P_beh_opt; P_beh_ultra; P_MBE; P_MBE_opt; P_MBE_ultra];
% 
% bar(x,y, 'stacked')
figure(2)
h = bar(x,y)
set(h, {'DisplayName'}, {'normalized delay','normalized area ','normalized delay-area product'}')
%set(h, {'DisplayName'}, {'delay / ns','Area'}')
legend()
% 
% figure(3)
% bar(x,y_P)
