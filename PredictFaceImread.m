function [img_matrix,label] = PredictFaceImread(n_persons)
%测试图片读入
%   输入 -n_persons 测试识别人数，即类别数量
%%设置矩阵大小以及初始化矩阵
imgrow=200;imgcol=200;
label=zeros(n_persons,1);
img_matrix=zeros(n_persons,imgrow*imgcol);
%%图片读入
for i = 1 : n_persons
    %图片路径设置以及拼接
    facepath=strcat('C:\Users\果冻\Desktop\大三\数字图像处理\课设\fin_img\',num2str(i));  %路径因不同情况而定
    cachepath=facepath;
    facepath=cachepath;
    %记录测试图片标签
    label(i)=i;
    facepath=strcat(facepath,'.bmp');
    %读入图片转为灰度图并转为行向量赋值到图片矩阵中
    img=imread(facepath);
    img=rgb2gray(img);
    %imshow(img);
    img_matrix(i,:)=img(:)';
end
        
    