clear all;
close all;
clc;
[FileName,PathName]=uigetfile({'*';},'select image file');
  
im        =   imread([PathName,FileName]);
[m n ch]  =   size(im);

sr2 = 3780;
sr3 = 5670;
sr4 = 7560;

im_h = imresize(im,[sr4,sr4],"nearest");
