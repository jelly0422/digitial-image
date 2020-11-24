function [img,result]=facedetetion(img)
% img为输入图像
% result为人脸检测后得到的二值图

y=rgb2ycbcr(img);
[r,c,l]=size(y);
cb=double(y(:,:,2)); %得到图像的Cb分量
cr=double(y(:,:,3)); %得到图像的Cr分量
%计算每个像素点的肤色概率
p=zeros(r,c);
for i=1:r
    for j=1:c
        w=[cb(i,j) cr(i,j)]; %色度矩阵
        m=[123.4516 147.5699]; %肤色均值
        n=[97.0916 23.3700;23.3700 137.9966]; %协方差矩阵，对应此处离散高斯分布
        p(i,j)=exp((-0.5)*(w-m)*inv(n)*(w-m)'); %计算肤色概率，即相似度
    end
end
binaryImage=p./max(max(p));%归一化结果
%下面开始阈值化
th=0.5;
for i=1:r
    for j=1:c
        if(binaryImage(i,j)>th) 
            binaryImage(i,j)=1;
        else
            binaryImage(i,j)=0;
        end
    end
end

%做数学形态学处理
se=strel('square',6);
binaryImage=imopen(binaryImage,se); %开运算,断开狭窄的连接
%figure;subplot(141);imshow(binaryImage);
binaryImage=imclose(binaryImage,se); %闭运算，填补狭窄的缺口，填小洞
%subplot(142);imshow(binaryImage);
binaryImage=imfill(binaryImage,'holes');%填洞
%subplot(143);imshow(binaryImage);
se1=strel('square',9); 
binaryImage=imopen(binaryImage,se1); %用大一点的结构元进行开运算,断开狭窄的连接
%subplot(144);imshow(binaryImage);

%剔除形态学上不像人脸的部分
[result,num]=bwlabel(binaryImage,4);%连通域
Area=[];
for i=1:num %根据白色区域长宽比例剔除非人脸
[r,c]=find(result==i);
row=max(r)-min(r);%区域高度
col=max(c)-min(c);%区域宽度
temp=size(r);
if(row/col>2.2)||(row/col<0.8) %判断是否符合长宽比范围
for k=1:temp
result(r(k),c(k))=0; %剔除像手脚这些非常长的宽的非人脸
end
else
Area(end+1)=row*col;
continue;
end
end

%剔除比人脸小很多的部分
[result,num]=bwlabel(result);
B=regionprops(result,'area');
Se=[B.Area];
avg_Se=mean(Se(:));
for i=1:num
[r,c]=find(result==i);
n_area=Se(i);
if (n_area/avg_Se<0.65)
for k=1:size(r)
result(r(k),c(k))=0; %剔除面积比人脸小很多的非人脸部分
end
else
continue;
end
end
end