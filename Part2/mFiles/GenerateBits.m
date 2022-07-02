function bit_seq = GenerateBits(L)
bit_seq = randi([0 1],[L 1]);

for i = 1:length(bit_seq)
    if bit_seq(i) == 0
        bit_seq(i)= -1;
    end    
end