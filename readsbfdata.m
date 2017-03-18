fid = fopen('20130404225200.sbf','rb');%

if (fid < 0)
       disp('Can not Open The File!');
end
fseek(fid, 0, 1);
filelen = ftell(fid);  %�����ļ����� �ֽ� ��λ
fseek(fid, 0, -1);

freq_num_block = filelen / 4096;   %����Ƶ�ʵ� block ��С 4096�ֽ�
filestream = fread(fid,filelen, 'uint8');
for i = 1 : freq_num_block
    imageO(:, i) = filestream((i-1)*4096 + 67 : (i-1)*4096 + 66 + 360);   % ���ݸ�ʽ ÿ��Ƶ�� 4096�ֽ�
    imageX(:, i) = filestream((i-1)*4096 + 571 : (i-1)*4096 + 570 + 360);%% 60�ֽ���ͷ + 6�ֽ� O��ͷ + 360�ֽ�O������  + 144�ֽ���� + 6�ֽ� X��ͷ + 360�ֽ�X������ + 144��� 
end
imageO(:,1:2) = 0; % ǰ�������ݲ�����
imageX(:,1:2) = 0;


%% ȥ�� O�� X�� ���
%Ϊ��.raw ���ݷ�Χͳһ��0-32��������ѹ�� 256/8 = 32
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



