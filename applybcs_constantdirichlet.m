function [force,ifix,gammag] = applybcs_constantdirichlet(x,y,numnod,length,height)

force = zeros(1,numnod*2);
ifix = zeros(2,numnod);
gammag = zeros(2,numnod);

for i=1:numnod
   if (x(i) == 0 || x(i) == length || y(i)==-height/2 || y(i)==-height/2+height )
      ifix(2*i-1) = 1.0;
      ifix(2*i) = 1.0;
   end
   
   if (x(i)==0)
       force(2*i) = 1;
       force(2*i-1) = 1;
   end
   if (x(i) == length)
       force(2*i) = 1;
       force(2*i-1) = 1;
   end
   if (y(i) == -height/2)
       force(2*i) = 1;
       force(2*i-1) = 1;
   end
   if (y(i)==-height/2+height)
       force(2*i) = 1;
       force(2*i-1) = 1;
   end
   
end

