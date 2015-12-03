% BIQUADRATIC MESH GENERATION PROGRAM FOR 2D HEAT

function[x,y,node,numele,numnod] = biquadraticmesh2d(length,height)

% number of elements in each direction
ndivl = 10;
ndivw = 10;

numele = ndivw*ndivl;
numnod = (2*ndivl+1)*(2*ndivw+1);

% set up nodal coordinates

for i = 1:(2*ndivl+1)
   for j=1:(2*ndivw+1)
      x((2*ndivw+1)*(i-1)+j) = (length/(2*ndivl))*(i-1);
      y((2*ndivw+1)*(i-1)+j) = height/2 -(height/(2*ndivw))*(j-1);
   end
end

% set up connectivity array

for j=1:ndivl
   for i=1:ndivw
      elemn = (j-1)*ndivw + i;
      nodet(elemn,1) = 2*elemn-1 + (2*ndivw+1)*(j-1)+(j-1);
      nodet(elemn,5) = nodet(elemn,1) + 1;
      nodet(elemn,2) = nodet(elemn,5) + 1;
      nodet(elemn,6) = nodet(elemn,2) + (2*ndivw + 1);
      nodet(elemn,9) = nodet(elemn,6) - 1;
      nodet(elemn,8) = nodet(elemn,9) - 1;
      nodet(elemn,4) = nodet(elemn,8) + (2*ndivw + 1);
      nodet(elemn,7) = nodet(elemn,4) + 1;
      nodet(elemn,3) = nodet(elemn,7) + 1;
   end
end

node = nodet';