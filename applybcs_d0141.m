% Boundary conditions for temperature = 0, 1, 4, and 1 on each side respectively

function [force,ifix] = applybcs_d0141(x,y,numnod,length,height)

force = zeros(1,numnod);
ifix = zeros(1,numnod);

for i=1:numnod
   if (x(i) == 0 || x(i)==length || y(i)==-height/2 || y(i)==-height/2+height)
      ifix(i) = 1.0;
   end
   
   if (x(i)==0)
       force(i) = 0;
   end
   if (x(i) == length)
       force(i) = 4;
   end
   if (y(i) == -height/2)
       force(i) = 1;
   end
   if (y(i)==-height/2+height)
       force(i) = 1;
   end
end


