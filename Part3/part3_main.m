function part3_main()

    B = 196;
    L = 2;
    P = 0.8;
    
    % Generate a bit sequence
    bit_seq = GenerateBits(B); % Generate a sequence of bits equal to the total number of bits
    
    BER_rep = RepetitionCode(bit_seq,B,L,P)

    BER_conv = ConvolutionalCode(bit_seq,B,P)
    

end
