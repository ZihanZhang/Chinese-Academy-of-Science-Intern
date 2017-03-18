clc;clear;close all;
sbffilestruc=dir('*.sbf');
N=numel(sbffilestruc);
 for i=1:N
     filename=sbffilestruc(i).name;
     SbfConvert(filename);
 end