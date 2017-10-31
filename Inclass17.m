%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results.

img1=imread('img1.tif');
img2=imread('img2.tif');

diffs=zeros(799);

for c=1:799
    for r=1:799
    pix1=img1((800-r):800,(800-c):800);
    pix2=img2(1:(1+r),1:(1+c));
    corr(r,c)=mean2((pix1-mean2(pix1)).*(pix2-mean2(pix2)));
    end
end
[max_c,r]=max(corr);
[max_r,c]=max(max_c);
pos=[r(c),c];

rows=r(c);
cols=c;

imgshift=zeros(size(img2)+[800-rows,800-cols]);
imgshift((end-800)+1:end,(end-800)+1:end)=img2;
figure;
imshowpair(img1,imgshift);

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
