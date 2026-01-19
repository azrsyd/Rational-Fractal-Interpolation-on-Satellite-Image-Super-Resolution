clear all;
close all;
% clc;
[FileName,PathName]=uigetfile({'*';},'select image file');
  
im        =   imread([PathName,FileName]);
[m n ch]  =   size(im);
size_ori = size(im);

% figure,imshow(im)

scale = 2;

% LR images are obtained by down-sampling the HR images directly along both the horizontal and vertical directions by a factor of 2, 3, or 4.
        % The initial image must be resized before processing to to avoid matrix size inequality at the end of the process
        transform = im(1:scale:end,1:scale:end,:);
        Rsize = size(transform,1);
        Csize = size(transform,2);
        Rfactor = size((1:2:Rsize),2);
        Cfactor = size((1:2:Csize),2);
        if scale==2
            Rsize = 4*Rfactor;
            Csize = 4*Cfactor;
            im = imresize(im,[Rsize Csize]);
        elseif scale==3
            Rsize = 6*Rfactor;
            Csize = 6*Cfactor;
            im = imresize(im,[Rsize Csize]);
        else
            Rsize = 8*Rfactor;
            Csize = 8*Cfactor;
            im = imresize(im,[Rsize Csize]);
        end
        LR  =  im(1:scale:end,1:scale:end,:);

         if  ch == 3
        % change color space, work on illuminance only
%~~~~~~~~~~~~~~~YCbCr~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
        im_l_ycbcr = rgb2ycbcr(LR);
        im_l_y = im_l_ycbcr(:, :, 1);
        im_l_cb = im_l_ycbcr(:, :, 2);
        im_l_cr = im_l_ycbcr(:, :, 3);
        im_l_y=double(im_l_y);
        im_l_cb=double(im_l_cb);
        im_l_cr=double(im_l_cr);

        im_h_y = imresize(im_l_y, scale, 'nearest');
        im_h_cb = imresize(im_l_cb, scale, 'nearest');
        im_h_cr = imresize(im_l_cr, scale, 'nearest');
        [nrow, ncol] = size(im_h_y);

        im_h_ycbcr = zeros([nrow, ncol, 3]);
        im_h_ycbcr(:, :, 1) = im_h_y;
        im_h_ycbcr(:, :, 2) = im_h_cb;
        im_h_ycbcr(:, :, 3) = im_h_cr;
        im_h = ycbcr2rgb(uint8(im_h_ycbcr));
        % show the images
%         figure, imshow(im_h);

% ~~~~~~~~~~~~~~~~~RGB~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%           im_l_r = LR(:,:,1);
%           im_l_g = LR(:,:,2);
%           im_l_b = LR(:,:,3);
%           im_l_r = double(im_l_r);
%           im_l_g = double(im_l_g);
%           im_l_b = double(im_l_b);
% 
%           im_h_r = imresize(im_l_r, scale, 'bicubic');
%           im_h_g = imresize(im_l_g, scale, 'bicubic');
%           im_h_b = imresize(im_l_b, scale, 'bicubic');
% 
%           [nrow, ncol] = size(im_h_r);
%           im_h = zeros([nrow, ncol, 3]);
%           im_h(:, :, 1) = im_h_r;
%           im_h(:, :, 2) = im_h_g;
%           im_h(:, :, 3) = im_h_b;
%           im_h = uint8(im_h);

        % show the images
%         figure, imshow(im_h);
         end
% ~~~~~~~~~~~~~~~~~~~~Testing~~~~~~~~~~~~~~~~~~~~~~~~~~~
psnr1(im,im_h)
ssim(im,im_h)
