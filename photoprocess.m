l=imread('123.png');
m=histeq(l);
subplot(121);imshow(l);title('未处理');
subplot(122);imshow(m);title('已处理');