%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results.

img1=imread('img1.tif');
img2=imread('img2.tif');

diffs=zeros(1,799);

for ov=1:799
    pix1=img1(:,(end-ov):end);
    pix2=img2(:,1:(ov+1));
    diffs(ov)=sum(sum(abs(pix1-pix2)))/ov;
end
figure;plot(diffs);

diffs2=zeros(799,1);

for ov=1:799
    pix1=img1((end-ov):end,:);
    pix2=img2(1:ov+1,:);
    diffs2(ov)=sum(sum(abs(pix1-pix2)))/ov;
end
figure;plot(diffs2);

[~,overlap2]=min(diffs2);

[~,overlap]=min(diffs);
img22=img2;
img22(1:800-overlap2, 1:800-overlap)=0;
imshowpair(img1,img22);

%fourier space
img1=imread('img1.tif');
img2=imread('img2.tif');
img1ft=fft2(img1);img2ft=fft2(img2);
[nr,nc]=size(img2ft);
CC=ifft2(img1ft.*conj(img2ft));
CCabs=abs(CC);
figure;imshow(CCabs,[]);

[row,col]=find(CCabs==max(CCabs(:)));
Nr=ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc=ifftshift(-fix(nc/2):ceil(nc/2)-1);
rows=Nr(row);
cols=Nc(col);

imgshift=zeros(size(img2)+[800-rows,800-cols]);
imgshift((end-800)+1:end,(end-800)+1:end)=img2;
figure;
imshowpair(img1,imgshift);
