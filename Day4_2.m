l=imread('cell.tif');
figure,imshow(l)
title('original cell');
BWs=edge(l,'sobel',(graythresh(l)*.1));
figure
imshow(BWs)
title('binary gradient mask');
se=strel('disk',5);
p1=imdilate(BWs,se);
figure
imshow(p1)
title('dilation');
figure
p2=imfill(p1,'holes');
imshow(p2)
title('fill HOLES!');
p3=imclearborder(p2,4);
figure
imshow(p3)
title('clear border');
seD=strel('diamond',1);
p4=imerode(p3,seD);
p5=imerode(p3,seD);
figure
imshow(p5)
title('cell detect');