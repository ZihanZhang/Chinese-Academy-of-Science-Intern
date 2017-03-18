fid = fopen('20130404225200.sbf','rb');%

if (fid < 0)
       disp('Can not Open The File!');
end
fseek(fid, 0, 1);
filelen = ftell(fid);  %计算文件长度 字节 单位
fseek(fid, 0, -1);

freq_num_block = filelen / 4096;   %计算频率点 block 大小 4096字节
filestream = fread(fid,filelen, 'uint8');
for i = 1 : freq_num_block
    imageO(:, i) = filestream((i-1)*4096 + 67 : (i-1)*4096 + 66 + 360);   % 数据格式 每个频点 4096字节
    imageX(:, i) = filestream((i-1)*4096 + 571 : (i-1)*4096 + 570 + 360);%% 60字节组头 + 6字节 O波头 + 360字节O波数据  + 144字节填充 + 6字节 X波头 + 360字节X波数据 + 144填充 
end
imageO(:,1:2) = 0; % 前两列数据不能用
imageX(:,1:2) = 0;


%% 去除 O波 X波 混叠
%为和.raw 数据范围统一【0-32】将数据压缩 256/8 = 32
imageO = imageO ./ 8;
imageX = imageX ./ 8;
for i = 1 : 360
    for j = 1 : freq_num_block
        if (imageO(i,j) > imageX(i,j) && imageO(i,j) >20)
            imageX(i,j) = 0;
        elseif (imageX(i,j) > imageO(i,j) && imageX(i,j) > 20)
            imageO(i,j) = 0;
        end
    end
end

imageO = flipud(imageO);
imageX = flipud(imageX);
figure,imagesc(imageO);colormap(gray);



