function [force,ifix,gammag] = applybcs(x,y,numnod,length,height)

force = zeros(1,numnod);
ifix = zeros(1,numnod);
gammag = zeros(1,numnod);

for i=1:numnod
   if (x(i) == 0 || x(i)==length || y(i)==-height/2 || y(i)==-height/2+height )
      ifix(i) = 1.0;
   end
   
   if (x(i)==0)
       force(i) = 1;
   end
   if (x(i) == length)
      %if (y(i) == 0.0)
         force(i) = 4;
      %end
   end
   if (y(i) == -height/2)
       force(i) = 1;
   end
   if (y(i)==-height/2+height)
       force(i) = 1;
   end
end


