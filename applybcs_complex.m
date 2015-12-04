function [force,ifix,gammag] = applybcs_complex(x,y,numnod,length,height)

force = zeros(1,numnod);
ifix = zeros(1,numnod);
gammag = zeros(1,numnod);

for i=1:numnod
   if (x(i)==length || y(i)==-height/2 )%|| y(i)==-height/2+height )
      ifix(i) = 1.0;
   end
   
   if (x(i) == length)
         force(i) = 10-y(i)^2/height/height*10;
   end
   if (y(i) == -height/2)
       force(i) = 1+sin(x(i));
   end
%    if (y(i)==-height/2+height)
%        force(i) = 1+cos(x(i));
%    end
end


