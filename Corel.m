clear all;
close all;
% clc;
[FileName,PathName]=uigetfile({'*';},'select image file');
  
im        =   imread([PathName,FileName]);

[FileName,PathName]=uigetfile({'*';},'select image file');
  
im_h        =   imread([PathName,FileName]);

psnr1(im,im_h)
ssim(im,im_h)