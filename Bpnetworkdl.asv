defaultpoints=20;    %%%%%%%%%隐含层节点数
inputpoints=1;       %%%%%%%%%输入层节点数
outputpoints=1;      %%%%%%%%%输出层节点数
Testerror=zeros(1,100);%%%%每个测试点的误差记录
a=zeros(1,inputpoints);%%%%输入层节点值
y=zeros(1,outputpoints);%%%样本节点输出值

w=zeros(inputpoints,defaultpoints);%%%%%输入层和隐含层权值
%初始化权重很重要，比如用rand函数初始化则效果非常不确定，不如用zeros初始化
v=zeros(defaultpoints,outputpoints);%%%%隐含层和输出层权值

bin=rand(1,defaultpoints);%%%%%隐含层输入
bout=rand(1,defaultpoints);%%%%隐含层输出
base1=0*ones(1,defaultpoints);%隐含层阈值，初始化为0

cin=rand(1,outputpoints);%%%%%%输出层输入
cout=rand(1,outputpoints);%%%%%输出层输出
base2=0*rand(1,outputpoints);%%输出层阈值
error=zeros(1,outputpoints);%%%拟合误差
errors=0;error_sum=0;       %%%误差累加和
error_rate_cin=rand(defaultpoints,outputpoints);%%误差对输出层节点权值的导数
error_rate_bin=rand(inputpoints,defaultpoints);%%%误差对输入层节点权值的导数

alfa=0.5;   %%%%  alfa 是隐含层和输出层权值-误差变化率的系数，影响很大
belt=0.5;   %%%%  belt 是隐含层和输入层权值-误差变化率的系数，影响较小
gama=5;     %%%%  gama 是误差放大倍数，可以影响跟随速度和拟合精度,当gama大于2时误差变大，容易震荡

%%%%规律  100个隐含节点，当alfa *gama =1.5时，效果好，其他值误差变大，belt基本不影响效果
%%%%规律  200个隐含节点，当alfa *gama =0.7时，效果好，其他值误差变大，belt基本不影响效果，最小误差和100个隐含点一样
%%%%规律  50个隐含节点，当alfa *gama =3时，效果好，其他值误差变大，belt基本不影响效果，最小误差和100个隐含点一样

trainingROUND=200;% 训练次数,有时训练几十次比训练几百次上千次效果要好很多
sampleNUM=361;   % 样本点数
x1=zeros(sampleNUM,inputpoints);   %样本输入矩阵
y1=zeros(sampleNUM,outputpoints);  %样本输出矩阵
x2=zeros(sampleNUM,inputpoints);   %测试输入矩阵
y2=zeros(sampleNUM,outputpoints);  %测试输出矩阵
observeOUT=zeros(sampleNUM,outputpoints); %%拟合输出监测点矩阵

i=0;j=0;k=0;  %%%%其中j是在一个训练周期中的样本点序号，不可引用
i=0;h=0;o=0;  %%%%输入层序号，隐含层序号，输出层序号
x=0:0.2*pi:2*pi;   %%%%步长

for j=1:9   %%%%%%这里给样本输入和输出赋值，应根据具体应用来设定
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
%归一化，使得输出范围落到[0,1]区间上，当激活函数为对数S型时适用
y2(:,o)=(y2(:,o)-min(y2(:,o)))/(max(y2(:,o))-min(y2(:,o)));
end

for  i=1:inputpoints
x1(:,i)=(x1(:,i)-min(x1(:,i)))/(max(x1(:,i))-min(x1(:,i)));
%输入数据归一化范围要和输出数据的范围相同，[0,1]
x2(:,i)=(x2(:,i)-min(x2(:,i)))/(max(x2(:,i))-min(x2(:,i)));
end
sampleNUM=9;
for  mmm=1:trainingROUND   %训练开始，100次
    error_sum=0;   
   if mmm==trainingROUND
       sampleNUM=361;
   end
for j=1:sampleNUM   %%%%%每次训练一个样本点
    
  for i=1:inputpoints  %%%%%样本输入层赋值
        a(i)=x1(j,i);  
  end
  for o=1:outputpoints %%%%%样本输出层赋值
           y(o)=y1(j,o);
  end
    if mmm==trainingROUND
       for i=1:inputpoints  %%%%%样本输入层赋值
        a(i)=x2(j,i);  
       end
       for o=1:outputpoints %%%%%样本输出层赋值
           y(o)=y2(j,o);
        end
   end
       
for h=1:defaultpoints
    bin(h)=0;
    for i=1:inputpoints
      bin(h)=bin(h)+a(i)*w(i,h);
    end
    bin(h)=bin(h)-base1(h);
    bout(h)=1/(1+exp(-bin(h)));%%%%%%隐含层激励函数为对数激励
end

temp_error=0;
for o=1:outputpoints
    cin(o)=0;
    for h=1:defaultpoints
       cin(o)=cin(o)+bout(h)*v(h,o);
    end
    cin(o)=cin(o)-base2(o);
    cout(o)=1/(1+exp(-cin(o)));    %%%%%%输出层激励函数为对数激励
    observeOUT(j,o)=cout(o);
    error(o)=y(o)-cout(o);
    temp_error=temp_error+error(o)*error(o);%%%%%记录实际误差，不应该乘伽玛系数
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
     %%%%base1变化不影响最小误差，但是可以抑制由于过多训练产生的发散效果
    for  o=1:outputpoints
    v(h,o)=v(h,o)+alfa*error_rate_cin(o)*bout(h);   %  可能要改，正负号？
     % base1(i)=base1(i)+0.01*alfa*error(i);
    end
    for i=1:inputpoints
    w(i,h)=w(i,h)+belt*error_rate_bin(h)*a(i);  %  可能要改，正负号？
        %base2=base2+0.01*belt*out_error;
    end
end

end
         %%%%%%%%一轮训练结束
   if(error_sum<0.01) 
     %%%%error_sum中记录一轮训练中所有样本的所有输出和拟合输出值差值平方和
     break;
   end

end    %//训练结束

figure
plot(x(1:sampleNUM),Testerror(1:sampleNUM),'r+')
hold on
plot(x(1:sampleNUM),y2(1:sampleNUM,1),'*')
hold on
plot(x(1:sampleNUM),observeOUT(1:sampleNUM,1),'o')
hold on
ylabel(num2str(mmm));
xlabel(num2str(error_sum));