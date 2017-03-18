l=imread('cameraman.tif');
J=imnoise(l,'salt & pepper',0.02);
K=imnoise(l,'gaussian',0,0.005);
subplot(231),imshow(l),title('cameraman');
subplot(232),imshow(J),title('cameraman with salt & pepper');
subplot(233),imshow(K),title('cameraman with gaussian');
[N,M]=size(J);
Squares=zeros(3,3);
Outputaver=zeros(N,M);
for i=1:N-3
    for j=1:M-3
        Squares=J(i:i+3,j:j+3);
        s=sum(Squares(:));
        h=s/9;
        Outputaver(i+1,j+1)=h;
    end;
end;
subplot(234),imshow(uint8(Outputaver)),title('method1');
Lines=zeros(1,5);
Outputmid=zeros(N,M);
for i=1:N
    for j=1:M-5
        Lines=K(i,j:j+5);
        s=median(Lines);
        Outputmid(i,j+2)=s;
    end;
end;
subplot(235),imshow(uint8(Outputmid)),title('method2');
x=zeros(3,3);
for i=1:N-3
    for j=1:M-3 
        x=sort(Squares);
        
    end;
end;