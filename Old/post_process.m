function [stresse] = post_process(node,x,y,gauss,young,pr,e,disp);
%2D quad element stress computation routine

% plane stress D matrix
fac = young(e)/(1 - (pr(e))^2);
D = fac*[1.0, pr(e), 0;
         pr(e), 1.0, 0.0;
         0, 0, (1.-pr(e))/2 ];
      
% element displacement vector
for j=1:4
   m1 = node(j,e)*2 - 1;
   m2 = node(j,e)*2;
   dispj(j*2-1) = disp(m1);
   dispj(j*2) = disp(m2);
end

% compute B matrix at quad point
one = ones(1,4);
psiJ = [-1, +1, +1, -1]; etaJ = [-1, -1, +1, +1];

% get coordinates of element nodes 
for j=1:4
   je = node(j,e); xe(j) = x(je); ye(j) = y(je);
end

eta = gauss(1);  psi = gauss(1);
% compute derivatives of shape functions in reference coordinates
NJpsi = 0.25*psiJ.*(one + eta*etaJ);
NJeta = 0.25*etaJ.*(one + psi*psiJ);
% compute derivatives of x and y wrt psi and eta
xpsi = NJpsi*xe'; ypsi = NJpsi*ye'; xeta = NJeta*xe';  yeta = NJeta*ye';
Jinv = [yeta, -xeta; -ypsi, xpsi];
jcob = xpsi*yeta - xeta*ypsi;
% compute derivatives of shape functions in element coordinates
NJdpsieta = [NJpsi; NJeta];
NJdxy = Jinv*NJdpsieta;
% assemble B matrix
BJ = zeros(3,8);
BJ(1,1:2:7) = NJdxy(1,1:4);  BJ(2,2:2:8) = NJdxy(2,1:4);
BJ(3,1:2:7) = NJdxy(2,1:4);  BJ(3,2:2:8) = NJdxy(1,1:4);

% compute coordinates of centroid
centr = 0.25*ones(1,4);
xcen = centr*xe';
ycen = centr*ye';
xy = [xcen,ycen];

%stress at centroid
stressj = (1/jcob)*[D*BJ*dispj']';
stresse(1,2:3) = xy;
stresse(1,4:6) = stressj;
stresse(1,1) = e;
