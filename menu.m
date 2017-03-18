clear;
clc;
hf=figure;
set(hf,'menubar','none');
hm=uimenu(hf,'label','我的菜单');
hm_exgrid=uimenu(hm,'label','调用内敛函数','callback','alnn');