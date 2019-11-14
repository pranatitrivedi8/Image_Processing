clc;
clear all;
img = imread('imagepath''\polymersomes.tif');
imshow(img); title('original polymersomes image');
mean_g = 0;
mt = 0;
[row,col] = size(img);                                  % obtain row and col values
figure(); imhist(img); title('histogram of image');     % obtain histogram of image
h = imhist(img);
pi = h/(row.*col);

for i=1:1:256
 if pi(i)~=0
 lv=i;
 break
 end
end

for i=256:-1:1
 if pi(i)~=0
 hv=i;
 break
 end
end

lh = hv - lv;

for k = 1:256
 p1(k)=sum(pi(1:k));
 p2(k)=sum(pi(k+1:256));                                % obtain cumulative sums
end

for k=1:256
 m1(k)=sum((k-1)*pi(1:k))/p1(k);
 m2(k)=sum((k-1)*pi(k+1:256))/p2(k);                    % obtain cumulative mean
end

for k=1:256
 mean_g=(k-1)*pi(k)+mean_g;                             % obtain global intensity mean
end

for k =1:256
 var(k)=p1(k)*(m1(k)-mean_g)^2+p2(k)*(m2(k)-mean_g)^2;
end

[y,T]=max(var(:));
T=T+lv;
g=img;
g1=find(g>=T);                                          % thresholding
g(g1)=255;
g2=find(g<T);
g(g2)=0;
figure(); imshow(g); title('segmented image using Otsu''s thresolding');
