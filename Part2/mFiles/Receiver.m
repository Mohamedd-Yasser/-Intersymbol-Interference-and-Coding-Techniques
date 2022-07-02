function [X_Out] = Receiver(L,Rx_bit_seq_eql)
X_Out =[]; 
%Simple Detector  
for i=1:L
    if Rx_bit_seq_eql(i) > 0
        B =1; 
    else
        B=-1;
    end
    X_Out =[X_Out ; B];   
end
end