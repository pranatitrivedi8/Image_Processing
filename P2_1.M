clc;
clear all;
%img = imread('imagepath''\noisy_fingerprint.tif');
img = imread('imagepath''\polymersomes.tif');       %for Q2 (b)
imshow(img); title('Given fingerprint image');

figure(); imhist(img); title('histogram of fingerprint image');
[counts, r] = imhist(img);
i = 1;
mu = cumsum(counts);
T(i) = (sum(r.*counts))/mu(end);
T(i) = round(T(i));

mu2 = cumsum(counts(1:T(i)));
MBT = sum(r(1:T(i)).*counts(1:T(i)))/mu2(end);

mu3 = cumsum(counts(T(i):end));
MAT = sum(r(T(i):end).*counts(T(i):end))/mu3(end);
i = i+1;
T(i) = round((MAT + MBT)/2);

while abs(T(i)-T(i-1))>=1
    mu2=cumsum(counts(1:T(i)));
    MBT=sum(r(1:T(i)).*counts(1:T(i)))/mu2(end);
    mu3=cumsum(counts(T(i):end));
    MAT=sum(r(T(i):end).*counts(T(i):end))/mu3(end);
    i=i+1;
    T(i)=round((MAT+MBT)/2);
    Threshold=T(i);
end % Normalizing the threshold to the range [i, 1].

level = (Threshold - 1) / (r(end) - 1);
BW = im2bw(img,level);
figure(); imshow(BW); title('binary segmented image');
