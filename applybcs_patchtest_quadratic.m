% Boundary conditions for quadratic patch test

function [force,ifix] = applybcs_patchtest_quadratic(x,y,numnod,length,height)

force = zeros(1,numnod);
ifix = zeros(1,numnod);

for i=1:numnod
   if (x(i) == 0 || x(i) == length || y(i)==-height/2 || y(i)==-height/2+height )
      ifix(i) = 1.0;
   end
   %Let t=10+x+x^2+2y-3y^2
   if (x(i)==0)
       force(i) = 10+x(i)+1*x(i)^2+2*y(i)+3*y(i)^2;
   end
   if (x(i) == length)
       force(i) = 10+x(i)+1*x(i)^2+2*y(i)+3*y(i)^2;
   end
   if (y(i) == -height/2)
       force(i) = 10+x(i)+1*x(i)^2+2*y(i)+3*y(i)^2;
   end
   if (y(i)==-height/2+height)
       force(i) = 10+x(i)+1*x(i)^2+2*y(i)+3*y(i)^2;
   end
end


