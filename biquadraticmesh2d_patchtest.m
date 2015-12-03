% BIQUADRATIC MESH GENERATION PROGRAM FOR 2D HEAT

function[x,y,node,numele,numnod] = biquadraticmesh2d_patchtest(length,height)

% number of elements in each direction
ndivl = 3;
ndivw = 3;

numele = ndivw*ndivl;
numnod = (ndivl+2)*(ndivw+2);

% set up nodal coordinates

for i = 1:(ndivl+2)
   for j=1:(ndivw+2)
      x((ndivw+2)*(i-1)+j) = (length/(ndivl+1))*(i-1);
      y((ndivw+2)*(i-1)+j) = height/2 -(height/(ndivw+1))*(j-1);
   end
end

% set up connectivity array

for j=1:ndivl
   for i=1:ndivw
      elemn = (j-1)*ndivw + i;
      nodet(elemn,1) = elemn + (j-1)*2;
      nodet(elemn,5) = nodet(elemn,1) + 1;
      nodet(elemn,2) = nodet(elemn,5) + 1;
      nodet(elemn,6) = nodet(elemn,2) + ndivw + 2;
      nodet(elemn,9) = nodet(elemn,6) - 1;
      nodet(elemn,8) = nodet(elemn,9) - 1;
      nodet(elemn,4) = nodet(elemn,8) + ndivw + 2;
      nodet(elemn,7) = nodet(elemn,4) + 1;
      nodet(elemn,3) = nodet(elemn,7) + 1;
   end
end

node = nodet';