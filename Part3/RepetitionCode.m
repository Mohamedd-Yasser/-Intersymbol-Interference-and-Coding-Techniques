function BER_Rep = RepetitionCode(bit_seq,B,L,P)
    % System parameters
    R = 1/L;

    % Generate samples from bits
    sample_seq = GenerateSamples(bit_seq,L); % Generate a sequence of samples for each bit
    C = length(sample_seq);
    
    % Pass the sample sequence through the channel
    rec_sample_seq = BSC(sample_seq,P);   % Generate the received samples after passing through the bit flipping channel

    % Decode bits from received bit sequence
    rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,L);    % Decode the received bits

    % Compute the BER
    BER_Rep = ComputeBER(bit_seq,rec_bit_seq);   % Calculate the bit error rate

end
