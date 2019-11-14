%Q3 (a)
clc;
clear all;
img = imread('image path''circular_stroke.tif');
imshow(img); title('Input image');
[row col] = size(img);
w = (1/81)*(ones(9));                           % 9x9 averaging filter
g = imfilter(img, w, 'conv');                   % smooth image
figure(); imshow(g); title('Smooth image');     % display smooth image

%Q3 (b)
gB = im2bw(g,0.5);                              % Thresholding
figure(); imshow(gB); title('Thresholded image');

%Q3 (c)
b1 = bwboundaries(gB, 'noholes');               % px1 cell array; p is number of objects detected with given parameters
b = b1{1,1};                                    % npx2 matrix containing coordinates of boundary
gh = bound2im(b, row, col);
figure(); imshow(gh); title('binary image of outer boundary');  % displays boundary converted to image

%Q3 (d)
[s, su] = bsubsamp(b, 50);                      % subsampling at distance of 50 pixels
gk = bound2im(s, row, col);
figure(); imshow(gk); title('subsampled points');
cn = connectpoly(s(:,1), s(:,2));               % connect subsampled points with straight line segments
cn2 = bound2im(cn, row, col);
figure(); imshow(cn2); title('connected subsampled points')

%Q3 (e)
c= fchcode(su,8);                               % Freeman chain code for 8 connectivity
disp(c);
