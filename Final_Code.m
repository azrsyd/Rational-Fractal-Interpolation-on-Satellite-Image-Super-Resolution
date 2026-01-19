clear all;
close all;
clc;
[FileName,PathName]=uigetfile({'*';},'select image file');
  
im        =   imread([PathName,FileName]);
[m n ch]  =   size(im);
size_ori = size(im);
scale = 2;

figure,imshow(im)
    
    if  ch == 3
        % change color space, work on illuminance only
        im_l_ycbcr = rgb2ycbcr(im);
        im_l_y = im_l_ycbcr(:, :, 1);
        im_l_cb = im_l_ycbcr(:, :, 2);
        im_l_cr = im_l_ycbcr(:, :, 3);
        im_l_y=double(im_l_y);
        im_l_cb=double(im_l_cb);
        im_l_cr=double(im_l_cr);

        figure, imshow(im_l_y); title('Y');
        figure, imshow(im_l_cb); title('Cb');
        figure, imshow(im_l_cr); title('Cr');

        %expand the metrix
        [m n]=size(im_l_y);
        II(1:m,1:n) = im_l_y;
        II(m+1,:) = 2.*II(m,:) - II(m-1,:);
        II(:,n+1) = 2.*II(:,n) - II(:,n-1);
        II(m+2,:) = 2.*II(m+1,:) - II(m,:);
        II(:,n+2) = 2.*II(:,n+1) - II(:,n);
        II(m+3,:) =2.*II(m+2,:)-II(m+1,:);
        II(:,n+3) =2.*II(:,n+2)-II(:,n+1);
        II(m+4,:) =2.*II(m+3,:)-II(m+2,:);
        II(:,n+4) =2.*II(:,n+3)-II(:,n+2);

        III(1:m,1:n) = im_l_cb;
        III(m+1,:) = 2.*III(m,:) - III(m-1,:);
        III(:,n+1) = 2.*III(:,n) - III(:,n-1);
        III(m+2,:) = 2.*III(m+1,:) - III(m,:);
        III(:,n+2) = 2.*III(:,n+1) - III(:,n);
        III(m+3,:) =2.*III(m+2,:)-III(m+1,:);
        III(:,n+3) =2.*III(:,n+2)-III(:,n+1);
        III(m+4,:) =2.*III(m+3,:)-III(m+2,:);
        III(:,n+4) =2.*III(:,n+3)-III(:,n+2);

        IIII(1:m,1:n) = im_l_cr;
        IIII(m+1,:) = 2.*IIII(m,:) - IIII(m-1,:);
        IIII(:,n+1) = 2.*IIII(:,n) - IIII(:,n-1);
        IIII(m+2,:) = 2.*IIII(m+1,:) - IIII(m,:);
        IIII(:,n+2) = 2.*IIII(:,n+1) - IIII(:,n);
        IIII(m+3,:) =2.*IIII(m+2,:)-IIII(m+1,:);
        IIII(:,n+3) =2.*IIII(:,n+2)-IIII(:,n+1);
        IIII(m+4,:) =2.*IIII(m+3,:)-IIII(m+2,:);
        IIII(:,n+4) =2.*IIII(:,n+3)-IIII(:,n+2);
        
        % image super-resolution
        tic;
        alpha = 0.1;
        beta = 0.1;
        gamma = 50;
        S = 0.005;
        im_h_y = main_function(II,m,n,scale,alpha,beta,gamma,S);
        im_h_cb = main_function(III,m,n,scale,alpha,beta,gamma,S);
        im_h_cr = main_function(IIII,m,n,scale,alpha,beta,gamma,S);

    % upscale the chrominance simply by "bicubic" 
    [nrow, ncol] = size(im_h_y);
%     im_h_cb = imresize(im_l_cb, [nrow, ncol], 'bicubic');
%     im_h_cr = imresize(im_l_cr, [nrow, ncol], 'bicubic');
     
    im_h_ycbcr = zeros([nrow, ncol, 3]);
    im_h_ycbcr(:, :, 1) = im_h_y;
    im_h_ycbcr(:, :, 2) = im_h_cb;
    im_h_ycbcr(:, :, 3) = im_h_cr;
    im_h = ycbcr2rgb(uint8(im_h_ycbcr));

    % show the images
    figure, imshow(im_h);
%     fname            =   strcat('SRRFL_', im_name);    
%     imwrite(im_h, fullfile(out_dir, fname));  
    else
    
        I=double(im);
        %expand the metrix
        [m n]=size(I);
        II(1:m,1:n) = I;
        II(m+1,:) = 2.*II(m,:) - II(m-1,:);
        II(:,n+1) = 2.*II(:,n) - II(:,n-1);
        II(m+2,:) = 2.*II(m+1,:) - II(m,:);
        II(:,n+2) = 2.*II(:,n+1) - II(:,n);
        II(m+3,:) =2.*II(m+2,:)-II(m+1,:);
        II(:,n+3) =2.*II(:,n+2)-II(:,n+1);
        II(m+4,:) =2.*II(m+3,:)-II(m+2,:);
        II(:,n+4) =2.*II(:,n+3)-II(:,n+2);
    
        % image super-resolution
        im_h= main_function(II,m,n,scale);
        im_h=uint8(im_h);
        
        % show the images
        figure, imshow(im_h);
%         fname            =   strcat('SRRFL_', im_name);    
%     imwrite(im_h, fullfile(out_dir, fname));  
    end
    toc
