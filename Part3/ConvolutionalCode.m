function BER_conv = ConvolutionalCode(bit_seq,B,P)
    
    % Generate coded sequence
    encoded_seq = ConvolutionalEncoder(bit_seq, B);  
    
    % Pass the sample sequence through the channel
    rec_sample_seq = BSC(encoded_seq,P);   % Generate the received samples after passing through the bit flipping channel
    
    % Decode bits from received bit sequence using Viterbi Algorithm
    output_bits = ViterbiDecoder(rec_sample_seq, B);  % Decode the received bits
    
    % Compute the BER
    BER_conv = ComputeBER(bit_seq, output_bits);   % Calculate the bit error rate


end