clear;
clc;
L = 25;          %Number of bits
t = [1:L];
N = 5;           %Number of paths
Eb_No = 1;      
Eb = 1;
No = Eb / Eb_No;
% Generate of Transmitted symbols (BPSK)
Tx_bit_seq = GenerateBits(L);

figure
stem(t,Tx_bit_seq);
title('Transmitted signal');

% Generate Matrix of channel coeffients
MultiPath_Matrix=MultipathChannel(L,N);
 
noise = randn(size(Tx_bit_seq))*sqrt(No/2);              %Generate Noise
Rx_bit_seq = (MultiPath_Matrix*Tx_bit_seq) + noise ;     %The received signal Y

figure
stem(t,Rx_bit_seq);
title('Signal after multipath and channel noise');

% The out of the receiver 
Rx_bit_seq_eql= inv(MultiPath_Matrix)*Rx_bit_seq; 
X_Out =  Receiver(L,Rx_bit_seq_eql);

figure
stem(t,X_Out);
title('Output signal after demodulation');

%Calculation of BER 
Eb_No_dB_vector = -15:0;
BER=zeros(size(Eb_No_dB_vector));

for i= 1:length(Eb_No_dB_vector)
    
    No=Eb/( 10^(Eb_No_dB_vector(i)/10) );
    noise= randn(size(Rx_bit_seq))*sqrt(No/2);
    Rx_bit_seq = (MultiPath_Matrix*Tx_bit_seq) + noise ;
    Rx_bit_seq_eql= inv(MultiPath_Matrix)*Rx_bit_seq;
    X_Out = Receiver(L,Rx_bit_seq_eql);
    
    BER(i) = ComputeBER(Tx_bit_seq,X_Out);
end
%Plotting BER vs Eb/No in dB
figure
plot(Eb_No_dB_vector,BER);
xlabel('Eb/No(dB)');
ylabel('BER');