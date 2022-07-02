function BER = ComputeBER(bit_seq,rec_bit_seq)
L = length(bit_seq);
difference = 0;

for i= 1:L
    if bit_seq(i) ~= rec_bit_seq(i)
        difference = difference + 1 ;
    end
end
BER = difference/L;