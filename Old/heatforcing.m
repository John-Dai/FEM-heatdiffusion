function [ gammag, force ] = heatforcing(x,y,numnod,length)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
force = zeros(1,numnod*2);
for i=1:numnod
    if (x(i)==length)
        force(2*i)=-400;
    end

    end
end
end

