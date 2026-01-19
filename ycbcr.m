clear all;
close all;
clc;
[FileName,PathName]=uigetfile({'*';},'select image file');
  
im        =   imread([PathName,FileName]);
[m n ch]  =   size(im);
size_ori = size(im);
scale = 2;

figure,imshow(im)

im_l_ycbcr = rgb2ycbcr(im);
im_l_y = im_l_ycbcr(:, :, 1);
im_l_cb = im_l_ycbcr(:, :, 2);
im_l_cr = im_l_ycbcr(:, :, 3);
im_l_y=double(im_l_y);
im_l_cb=double(im_l_cb);
im_l_cr=double(im_l_cr);

figure, imshow(im_l_ycbcr); title('Ycbcr');
figure, imshow(im_l_y); title('Y');
figure, imshow(im_l_cb); title('Cb');
figure, imshow(im_l_cr); title('Cr');