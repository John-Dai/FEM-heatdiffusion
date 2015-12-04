% 2D FE PROGRAM FOR STREADY-STATE HEAT CONDUTION
clear
%INPUT DATA
length = 1;
height = 1;
[x,y,node,numele,numnod] = biquadraticmesh2d_patchtest(length,height);

%MATERIAL CONSTANTS
therm=204;

%FORCE AND DISPLACEMENT BC'S
[iforce,ifix] = applybcs_patchtest_linear(x,y,numnod,length,height);

%ASSEMBLY OF STIFFNESS
ndof = 1; %degrees of freedom per node
gauss = [-3^(-0.5), 3^(-0.5)];
numeqns = numnod*ndof;
bigk = zeros(numeqns);

%
% loop over elements
%
% nlink is # of nodes per element
nlink = 9;
for e = 1:numele
   [ke] = biquadraticelemstiff(node,x,y,gauss,therm,e);
   %
   % assemble ke into bigk
   %
   n1 = ndof-1;
   for i=1:nlink;
      for j=1:nlink;
         rbk = ndof*(node(i,e)-1) + 1;
         cbk = ndof*(node(j,e)-1) + 1;
         re = ndof*(i-1)+1;
         ce = ndof*(j-1)+1;
         bigk(rbk:rbk+n1, cbk:cbk+n1) = bigk(rbk:rbk+n1, cbk:cbk+n1) + ke(re:re+n1, ce:ce+n1);
      end;
   end;
end;

% enforce boundary conditions 
% essential bcs assumed homogeneous(?)
for n=1:numnod
   for j=1:ndof
      if (ifix(j,n) == 1)
         m = ndof*(n-1)+j;
         bigk(:,m) = zeros(numeqns,1);
         bigk(m,m) = 1.0;
      end
   end
end

%solve stiffness equations
rank(bigk)
disp = force/bigk;

disp(numnod)
figure(2)
scatter3(x,y,disp)



