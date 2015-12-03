clear
g = @squareg;
c = 1;
a = 0;
f = 0;
d = 1;

numberOfPDE = 1;
pdem = createpde(numberOfPDE);
geometryFromEdges(pdem,g);

% Plot the geometry and display the edge labels for use in the boundary
% condition definition.
figure(1)
pdegplot(pdem, 'edgeLabels', 'on');
axis([-1.1 1.1 -1.1 1.1]);
title 'Geometry With Edge Labels Displayed'

% Solution is zero at all four outer edges of the square
applyBoundaryCondition(pdem,'Edge',1, 'u', 0);
applyBoundaryCondition(pdem,'Edge',2, 'u', 1);
applyBoundaryCondition(pdem,'Edge',3, 'u', 4);
applyBoundaryCondition(pdem,'Edge',4, 'u', 1);

msh = generateMesh(pdem);
figure(2);
pdemesh(pdem);
axis equal

[p,~,t] = meshToPet(msh);
u0 = zeros(size(p,2),1);
ix = find(sqrt(p(1,:).^2+p(2,:).^2)<0.4);
u0(ix) = ones(size(ix));

nframes = 200;
tlist = linspace(0,1000,nframes);

u1 = parabolic(u0,tlist,pdem,c,a,f,d);

figure(3)
colormap(cool);
x = linspace(-1,1,31);
y = x;
[~,tn,a2,a3] = tri2grid(p,t,u0,x,y);
umax = max(max(u1));
umin = min(min(u1));
%for j = 1:nframes,
    u = tri2grid(p,t,u1(:,nframes),tn,a2,a3);
    i = find(isnan(u));
    u(i) = zeros(size(i));
    surf(x,y,u);
    caxis([umin umax]);
    %axis([-1 1 -1 1 0 1]);
    %shading interp;
    %Mv(j) = getframe;
%end
%movie(Mv,1);