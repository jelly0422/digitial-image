function [img_matrix,label] = FaceImread(n_persons)
%%读取训练图片为向量
%   输入 -n_persons 人数
%   输出 -img_matrix 图片向量化矩阵
%        -label 各行的类别标签

%每一类训练的图片数量
nums=9;
%%训练的图片尺寸
imgrow=200;imgcol=200;
label=zeros(n_persons*nums,1);%定义标签矩阵
img_matrix=zeros(n_persons*nums,imgrow*imgcol);%定义图片向量矩阵
%%图片读入
for i = 1 : n_persons
    facepath=strcat('C:\Users\果冻\Desktop\大三\数字图像处理\课设\img2\',num2str(i),'\');%类路径
    cachepath=facepath;
    for j = 1 : nums
        %路径字符拼接
        facepath=cachepath;
        facepath=strcat(facepath,num2str(j));
        label((i-1)*nums+j)=i;%标签赋值
        facepath=strcat(facepath,'.bmp');
        %图片读入
        img=imread(facepath);
        img=rgb2gray(img);
        %imshow(img);%测试图片读入用
        %将图片灰度值转成行向量赋值在矩阵中
        img_matrix((i-1)*nums+j,:)=img(:)';
    end
end
        
    