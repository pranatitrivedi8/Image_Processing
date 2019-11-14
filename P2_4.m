%Q4 (a)
clc;
clear all;
img = imread('image path''chromosome.tif');
imshow(img); title('Input image');
[row col] = size(img);

b1=bwboundaries(img, 'noholes');
b = b1{1,1};
g=bound2im(b, row, col);                            % Boundary extraction
figure(); imshow(g); title('Extracted boundary of chromosome as binary image');

%Q4 (b) Computing Fourier descriptors
z=fourierdescp(b);

%Q4 (c) Reconstruct the boundary using a part of the Fourier descriptors
nd_50 = round(length(z)/2);                         % for 50% of total fourier descriptors
if(mod(nd_50,2)) ~= 0                               % to check if nd_50 is even integer
    nd_50 = nd_50 - 1;
end

nd_1 = round(length(z)/100);                        % for 1% of total fourier descriptors
if(mod(nd_1,2)) ~= 0                                % to check if nd_1 is even integer
    nd_1 = nd_1 - 1;
end

s1=ifourierdescp(z, nd_50);                         % Reconstruction using 50% of total descriptors
s1im=bound2im(s1, row, col);
figure(); imshow(s1im); title('Using 50% fourier descriptors');

s2=ifourierdescp(z, nd_1);                         % Reconstruction using 1% of total descriptors
s2im=bound2im(s2, row, col);
figure(); imshow(s2im); title('Using 1% fourier descriptors');
