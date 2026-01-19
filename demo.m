clear all;
close all;
% clc;
[FileName,PathName]=uigetfile({'*';},'select image file');
  
im        =   imread([PathName,FileName]);
[m n ch]  =   size(im);
size_ori = size(im);

figure,imshow(im)

%  downsample
    scale=4;         %% Scaling factors: 2, 3, 4
    %select down-sampling method
     dmethod=3;
    if dmethod == 1
        % bicubic down-sampling
        transform = imresize(im, 1/scale, 'bicubic');
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
        LR  =  imresize(im, 1/scale, 'bicubic');
    end
    if dmethod ==2
        % nearest neighbors down-samping
        transform = imresize(im, 1/scale, 'nearest');
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
        LR  =  imresize(im, 1/scale, 'nearest');
    end
    if dmethod==3
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
    end
    
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

% ~~~~~~~~~~~~~~~~~RGB~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%           im_l_r = LR(:,:,1);
%           im_l_g = LR(:,:,2);
%           im_l_b = LR(:,:,3);
%           im_l_r = double(im_l_r);
%           im_l_g = double(im_l_g);
%           im_l_b = double(im_l_b);

%         [m n]=size(im_l_r);
%         II(1:m,1:n) = im_l_r;
%         II(m+1,:) = 2.*II(m,:) - II(m-1,:);
%         II(:,n+1) = 2.*II(:,n) - II(:,n-1);
%         II(m+2,:) = 2.*II(m+1,:) - II(m,:);
%         II(:,n+2) = 2.*II(:,n+1) - II(:,n);
%         II(m+3,:) =2.*II(m+2,:)-II(m+1,:);
%         II(:,n+3) =2.*II(:,n+2)-II(:,n+1);
%         II(m+4,:) =2.*II(m+3,:)-II(m+2,:);
%         II(:,n+4) =2.*II(:,n+3)-II(:,n+2);
% 
%         III(1:m,1:n) = im_l_g;
%         III(m+1,:) = 2.*III(m,:) - III(m-1,:);
%         III(:,n+1) = 2.*III(:,n) - III(:,n-1);
%         III(m+2,:) = 2.*III(m+1,:) - III(m,:);
%         III(:,n+2) = 2.*III(:,n+1) - III(:,n);
%         III(m+3,:) =2.*III(m+2,:)-III(m+1,:);
%         III(:,n+3) =2.*III(:,n+2)-III(:,n+1);
%         III(m+4,:) =2.*III(m+3,:)-III(m+2,:);
%         III(:,n+4) =2.*III(:,n+3)-III(:,n+2);
% 
%         IIII(1:m,1:n) = im_l_b;
%         IIII(m+1,:) = 2.*IIII(m,:) - IIII(m-1,:);
%         IIII(:,n+1) = 2.*IIII(:,n) - IIII(:,n-1);
%         IIII(m+2,:) = 2.*IIII(m+1,:) - IIII(m,:);
%         IIII(:,n+2) = 2.*IIII(:,n+1) - IIII(:,n);
%         IIII(m+3,:) =2.*IIII(m+2,:)-IIII(m+1,:);
%         IIII(:,n+3) =2.*IIII(:,n+2)-IIII(:,n+1);
%         IIII(m+4,:) =2.*IIII(m+3,:)-IIII(m+2,:);
%         IIII(:,n+4) =2.*IIII(:,n+3)-IIII(:,n+2);
        
% image super-resolution
        tic;
        alpha = 0.1;
        beta = 0.1;
        gamma = 5;
        S = 0.005;

%         RGB
%         im_h_r = main_function(II,m,n,scale,alpha,beta,gamma,S);
%         im_h_g = main_function(III,m,n,scale,alpha,beta,gamma,S);
%         im_h_b = main_function(IIII,m,n,scale,alpha,beta,gamma,S);

%         [nrow, ncol] = size(im_h_r);
%         im_h = zeros([nrow, ncol, 3]);
%         im_h(:, :, 1) = im_h_r;
%         im_h(:, :, 2) = im_h_g;
%         im_h(:, :, 3) = im_h_b;
%         im_h = uint8(im_h);

    % YCbCr
    % upscale the chrominance simply by "bicubic" 
    im_h_y = main_function(II,m,n,scale,alpha,beta,gamma,S);

    [nrow, ncol] = size(im_h_y);
    im_h_cb = imresize(im_l_cb, [nrow, ncol], 'bicubic');
    im_h_cr = imresize(im_l_cr, [nrow, ncol], 'bicubic');
    
    im_h_ycbcr = zeros([nrow, ncol, 3]);
    im_h_ycbcr(:, :, 1) = im_h_y;
    im_h_ycbcr(:, :, 2) = im_h_cb;
    im_h_ycbcr(:, :, 3) = im_h_cr;
    im_h = ycbcr2rgb(uint8(im_h_ycbcr));
    % show the images
    figure, imshow(im_h);
    else
    
        I=double(LR);
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
        figure, imshow(im_h); 
    end
    toc
% imwrite(im_h,'L7_x2_high.png')imwrite(im_h,'L7_I_x4_high.png')
% imwrite(im_h,'hasil.png')
% psnr1(im,im_h)
% ssim(im,im_h)
   
