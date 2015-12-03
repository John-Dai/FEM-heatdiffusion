%
%  Heat equation  u_t = D lap(u), 0 < x < L, 0 < y < L  (a square)
%     Crank-Nicolson time stepping
%     Dirichlet boundary conditions
%
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

%  grid and time stepping parameters
clear
M =   64;  L =   1;  h = L/(M-1);  
T = 5;  NT = 10;  dt = T/NT;

x = 0:h:L; y = 0:h:L;
[xg yg] = meshgrid(x,y); 
tg = 0:dt:T;

%  Diffusion coefficient
D = 1;
lambda = D*dt/h^2;

clf reset

% generate & plot the vectorizing indices
   G = numgrid('S',M);
%   spy(G)
%   disp('pause'), disp(' '), pause

% Generate and display the discrete Laplacian.
%   lapl = sparse(-delsq(G)/h^2);
   lapl = -delsq(G)/h^2;
%   spy(full(lapl))
%   title('\bf banded matrix laplacian')
%   disp('pause'), disp(' '), pause

% Number of interior points (count when G_index > 0)
   
N = sum(G(:)>0);

%  Initial conditions and boundary conditions
   u = zeros(N,1);
   rhs = u + 0.5*D*dt*lapl*u;
%   rhs = u;
   UL = 1;  UR = 2;  UB = 1;  UT = 3;
   rhs(round(G(  2,2:M-1))) = rhs(round(G(  2,2:M-1)))+lambda*UB;
   rhs(round(G(M-1,2:M-1))) = rhs(round(G(M-1,2:M-1)))+lambda*UT;
   rhs(round(G(2:M-1,  2))) = rhs(round(G(2:M-1,  2)))+lambda*UL;
   rhs(round(G(2:M-1,M-1))) = rhs(round(G(2:M-1,M-1)))+lambda*UR;

% map "rhs" onto a grid & plot abs(rhs)

R = G;  R(G>0) = (full(rhs(G(G>0))) ~=0);

%      pcolor(xg,yg,R);  axis('equal');  axis([0 L 0 L]); 
%      shading flat;  colormap(jet);  
%      caxis([0 2]); colorbar;  axis square;  axis image
%title('\bf boundary data location check')
%xlabel('\bf x')
%ylabel('\bf y')
%   disp('pause'), disp(' '), pause

%  PDE solve with operation count

disp(' ')
disp(' Crank-Nicolson, 2d Heat Equation')
disp(' ')

%hmat = sparse(eye(N) - 0.5*D*dt*lapl);
hmat = eye(N) - 0.5*D*dt*lapl;
%hmat = sparse(eye(N) - D*dt*lapl);

for k=1:NT 
   time = k*dt;

% iteration
   tic;
   u = hmat\rhs;
   toc
   %stop

%  plot the solution (with BCs & corners = 0)

   U = G;  U(G>0) = full(u(G(G>0)));
   U(1,2:M-1) = UB;  U(2:M-1,1) = UL;
   U(M,2:M-1) = UT;  U(2:M-1,M) = UR;

%
% update right-hand side
%  Initial conditions and boundary conditions
   rhs = u + 0.5*D*dt*lapl*u;
%   rhs = u ;
   rhs(round(G(  2,2:M-1))) = rhs(round(G(  2,2:M-1)))+lambda*UB;
   rhs(round(G(M-1,2:M-1))) = rhs(round(G(M-1,2:M-1)))+lambda*UT;
   rhs(round(G(2:M-1,  2))) = rhs(round(G(2:M-1,  2)))+lambda*UL;
   rhs(round(G(2:M-1,M-1))) = rhs(round(G(2:M-1,M-1)))+lambda*UR;
   
% interval plotting
   if (mod(k,NT/10)==0); 
      pcolor(xg,yg,U);  axis('equal');  axis([0 L 0 L]); 
      shading flat;  colormap(jet);  
      caxis([0 3]); colorbar;  axis square;  axis image
      title('\bf Solution to Heat Equation')
      xlabel('\bf x')
      ylabel('\bf y')
   end

end

