
function alnn()
t=linspace(0,1,1024);
f=1;
x=sin(2*pi*f*t);
y=cos(2*pi*f*t);
z=y'*x;
surf(t,t,z);



end

