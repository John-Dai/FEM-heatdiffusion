function [result] = evaluateheat(x,y,length,height)
cn=1/sinh(2*pi*length/height);
result=cn*sinh(2*pi*x/height)*sin(2*pi*y/height);