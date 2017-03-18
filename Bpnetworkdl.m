defaultpoints=20;    %%%%%%%%%������ڵ���
inputpoints=1;       %%%%%%%%%�����ڵ���
outputpoints=1;      %%%%%%%%%�����ڵ���
Testerror=zeros(1,100);%%%%ÿ�����Ե������¼
a=zeros(1,inputpoints);%%%%�����ڵ�ֵ
y=zeros(1,outputpoints);%%%�����ڵ����ֵ

w=zeros(inputpoints,defaultpoints);%%%%%������������Ȩֵ
%��ʼ��Ȩ�غ���Ҫ��������rand������ʼ����Ч���ǳ���ȷ����������zeros��ʼ��
v=zeros(defaultpoints,outputpoints);%%%%������������Ȩֵ

bin=rand(1,defaultpoints);%%%%%����������
bout=rand(1,defaultpoints);%%%%���������
base1=0*ones(1,defaultpoints);%��������ֵ����ʼ��Ϊ0

cin=rand(1,outputpoints);%%%%%%���������
cout=rand(1,outputpoints);%%%%%��������
base2=0*rand(1,outputpoints);%%�������ֵ
error=zeros(1,outputpoints);%%%������
errors=0;error_sum=0;       %%%����ۼӺ�
error_rate_cin=rand(defaultpoints,outputpoints);%%���������ڵ�Ȩֵ�ĵ���
error_rate_bin=rand(inputpoints,defaultpoints);%%%���������ڵ�Ȩֵ�ĵ���

alfa=0.5;   %%%%  alfa ��������������Ȩֵ-���仯�ʵ�ϵ����Ӱ��ܴ�
belt=0.5;   %%%%  belt ��������������Ȩֵ-���仯�ʵ�ϵ����Ӱ���С
gama=5;     %%%%  gama �����Ŵ���������Ӱ������ٶȺ���Ͼ���,��gama����2ʱ�����������

%%%%����  100�������ڵ㣬��alfa *gama =1.5ʱ��Ч���ã�����ֵ�����belt������Ӱ��Ч��
%%%%����  200�������ڵ㣬��alfa *gama =0.7ʱ��Ч���ã�����ֵ�����belt������Ӱ��Ч������С����100��������һ��
%%%%����  50�������ڵ㣬��alfa *gama =3ʱ��Ч���ã�����ֵ�����belt������Ӱ��Ч������С����100��������һ��

trainingROUND=200;% ѵ������,��ʱѵ����ʮ�α�ѵ�����ٴ���ǧ��Ч��Ҫ�úܶ�
sampleNUM=361;   % ��������
x1=zeros(sampleNUM,inputpoints);   %�����������
y1=zeros(sampleNUM,outputpoints);  %�����������
x2=zeros(sampleNUM,inputpoints);   %�����������
y2=zeros(sampleNUM,outputpoints);  %�����������
observeOUT=zeros(sampleNUM,outputpoints); %%�������������

i=0;j=0;k=0;  %%%%����j����һ��ѵ�������е���������ţ���������
i=0;h=0;o=0;  %%%%�������ţ���������ţ���������
x=0:0.2*pi:2*pi;   %%%%����

for j=1:9   %%%%%%�������������������ֵ��Ӧ���ݾ���Ӧ�����趨
    x1(j,1)=x(j);
    y1(j,1)=sin(x1(j,1));
end
x=0:2*pi/361:2*pi;
for j=1:361
    x2(j,1)=x(j);
    y2(j,1)=sin(x2(j,1));   
end

for o=1:outputpoints
y1(:,o)=(y1(:,o)-min(y1(:,o)))/(max(y1(:,o))-min(y1(:,o)));
%��һ����ʹ�������Χ�䵽[0,1]�����ϣ��������Ϊ����S��ʱ����
y2(:,o)=(y2(:,o)-min(y2(:,o)))/(max(y2(:,o))-min(y2(:,o)));
end

for  i=1:inputpoints
x1(:,i)=(x1(:,i)-min(x1(:,i)))/(max(x1(:,i))-min(x1(:,i)));
%�������ݹ�һ����ΧҪ��������ݵķ�Χ��ͬ��[0,1]
x2(:,i)=(x2(:,i)-min(x2(:,i)))/(max(x2(:,i))-min(x2(:,i)));
end
sampleNUM=9;
for  mmm=1:trainingROUND   %ѵ����ʼ��100��
    error_sum=0;   
   if mmm==trainingROUND
       sampleNUM=361;
   end
for j=1:sampleNUM   %%%%%ÿ��ѵ��һ��������
    
  for i=1:inputpoints  %%%%%��������㸳ֵ
        a(i)=x1(j,i);  
  end
  for o=1:outputpoints %%%%%��������㸳ֵ
           y(o)=y1(j,o);
  end
    if mmm==trainingROUND
       for i=1:inputpoints  %%%%%��������㸳ֵ
        a(i)=x2(j,i);  
       end
       for o=1:outputpoints %%%%%��������㸳ֵ
           y(o)=y2(j,o);
        end
   end
       
for h=1:defaultpoints
    bin(h)=0;
    for i=1:inputpoints
      bin(h)=bin(h)+a(i)*w(i,h);
    end
    bin(h)=bin(h)-base1(h);
    bout(h)=1/(1+exp(-bin(h)));%%%%%%�����㼤������Ϊ��������
end

temp_error=0;
for o=1:outputpoints
    cin(o)=0;
    for h=1:defaultpoints
       cin(o)=cin(o)+bout(h)*v(h,o);
    end
    cin(o)=cin(o)-base2(o);
    cout(o)=1/(1+exp(-cin(o)));    %%%%%%����㼤������Ϊ��������
    observeOUT(j,o)=cout(o);
    error(o)=y(o)-cout(o);
    temp_error=temp_error+error(o)*error(o);%%%%%��¼ʵ������Ӧ�ó�٤��ϵ��
    error(o)=gama*error(o);
end
Testerror(j)=temp_error;
 error_sum=error_sum+Testerror(j);

for  o=1:outputpoints
     error_rate_cin(o)=error(o)*cout(o)*(1-cout(o));  
end

for h=1:defaultpoints 
    error_rate_bin(h)=0;
   for o=1:outputpoints
    error_rate_bin(h)= error_rate_bin(h)+error_rate_cin(o)*v(h,o);
   end
   error_rate_bin(h)=error_rate_bin(h)*bout(h)*(1-bout(h));
end

for h=1:defaultpoints  
     base1(h)=base1(h)-5*error_rate_bin(h)*bin(h);
     %%%%base1�仯��Ӱ����С�����ǿ����������ڹ���ѵ�������ķ�ɢЧ��
    for  o=1:outputpoints
    v(h,o)=v(h,o)+alfa*error_rate_cin(o)*bout(h);   %  ����Ҫ�ģ������ţ�
     % base1(i)=base1(i)+0.01*alfa*error(i);
    end
    for i=1:inputpoints
    w(i,h)=w(i,h)+belt*error_rate_bin(h)*a(i);  %  ����Ҫ�ģ������ţ�
        %base2=base2+0.01*belt*out_error;
    end
end

end
         %%%%%%%%һ��ѵ������
   if(error_sum<0.01) 
     %%%%error_sum�м�¼һ��ѵ�����������������������������ֵ��ֵƽ����
     break;
   end

end    %//ѵ������

figure
plot(x(1:sampleNUM),Testerror(1:sampleNUM),'r+')
hold on
plot(x(1:sampleNUM),y2(1:sampleNUM,1),'*')
hold on
plot(x(1:sampleNUM),observeOUT(1:sampleNUM,1),'o')
hold on
ylabel(num2str(mmm));
xlabel(num2str(error_sum));