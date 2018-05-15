function FaceMod(FNameOut)

[FName, FPath]=uigetfile('*.bmp','Choose a file to modify:');

img=imread(FName);
Msk=imread('MaskF.bmp')/255;
MskI=imread('MaskFi.bmp')/255;

imgMsk=img.*Msk;
imgMsk=img.*MskI;

Norm=100/mean(mean(imgMsk));
imgNorm=imgMsk*Norm;
disp(mean(mean(imgNorm)));
imwrite(imgNorm(:,:),sprintf('%s%s%s%s%s%s',FNameOut,'O','1','_F','0','.bmp'),'BMP');
imwrite(flipdim(imgNorm(:,:),1),sprintf('%s%s%s%s%s%s',FNameOut,'O','2','_F','0','.bmp'),'BMP');

FSize=[1 2 4 8 16 32 64 128];
for i=1:8;

    h = fspecial('average', [FSize(i),FSize(i)]);
    imgFiltMsk=imfilter(imgNorm,h).*Msk;
    Norm=100/mean(mean(imgFiltMsk));
    imgFiltNorm=imgFiltMsk*Norm;
    disp(mean(mean(imgFiltNorm)));
    
    imwrite(imgFiltNorm,sprintf('%s%s%s%s%s%s',FNameOut,'O','1','_F',num2str(i),'.bmp'),'BMP');
    imwrite(flipdim(imgFiltNorm,1),sprintf('%s%s%s%s%s%s',FNameOut,'O','2','_F',num2str(i),'.bmp'),'BMP');
end

    

