
clear all; clc;

data = {'A' 'B' 'C' 'A' 'B' 'D' 'A' 'G' 'H' 'A' 'Y' 'B' 'C' 'C' 'C' 'A' 'Z' 'H'}';

n_dat = length(data);
rep = ones(n_dat,1);

for iv = 2:n_dat
    for v = 1:(iv-1)
        if strcmp(data{iv},data{v})
            rep(iv) = rep(iv) + 1;
        end
    end
end

g = int2str(rep);

for vi = 1:n_dat
    if rep(vi) > 1
        dataREP{vi,1} = [data{vi} ' ' g(vi)];
    else
        dataREP{vi,1} = data{vi};
    end
end