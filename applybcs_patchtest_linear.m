function [force,ifix,gammag] = applybcs_patchtest_linear(x,y,numnod,length,height)

force = zeros(1,numnod);
ifix = zeros(1,numnod);
gammag = zeros(1,numnod);

for i=1:numnod
   if (x(i) == 0 || x(i) == length || y(i)==-height/2 || y(i)==-height/2+height )
      ifix(i) = 1.0;
   end
    %Let t=10+x+2y
   if (x(i)==0)
       force(i) = 10+x(i)+2*y(i);
   end
   if (x(i) == length)
       force(i) = 10+x(i)+2*y(i);
   end
   if (y(i) == -height/2)
       force(i) = 10+x(i)+2*y(i);
   end
   if (y(i)==-height/2+height)
       force(i) = 10+x(i)+2*y(i);
   end
end


