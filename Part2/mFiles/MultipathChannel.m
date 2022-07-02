function [channel_matrix] = MultipathChannel(L,N)

channel_matrix = zeros(L,L);
channel_attenuator = abs(randn(1));

for i =1:L
    for j = i:L
        channel_matrix(j,i) = exp(-(j-i)*10/N)*channel_attenuator;
    end 
end
end