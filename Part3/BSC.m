function rec_sample_seq  = BSC(sample_seq,P)
    % This function takes the sample sequence passing through the channel, and
    % generates the output sample sequence based on the specified channel type
    % and parameters

    sample_seq      = ~~sample_seq;
    rec_sample_seq  = zeros(size(sample_seq));
    rec_sample_seq  = ~~rec_sample_seq;


    channel_effect = rand(size(rec_sample_seq))<=P;

    rec_sample_seq = xor(sample_seq,channel_effect);
    rec_sample_seq = rec_sample_seq + 0;
end