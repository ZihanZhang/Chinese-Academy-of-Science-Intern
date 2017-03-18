function [Y] = normalization(X)
Num=size(X);
for i=1:Num
   Max=0;
   if(X(i)>Max)
       Max=X(i);
   end
end
for i=1:Num
   Min=1000;
   if(X(i)<Min)
       Min=X(i);
   end
end
for i=1:Num
    Y(i)=(X(i)-Min)/(Max-Min);
end
end

