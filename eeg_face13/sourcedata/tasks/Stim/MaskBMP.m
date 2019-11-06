[FName,FPath]=uigetfile('*.bmp','target bmp files','multiselect','on');

Mask=imread('MaskFi.bmp')/255;

for i=1:length(FName);
    img=imread(FName{i});
    imgMask=img.*Mask;
    imwrite(imgMask,FName{i},'BMP');
end
    