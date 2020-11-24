function [predict_label]=predict(img,label)
%%测试函数
%   输入 -img_matrix 测试图片矩阵
%        -label 测试图片标签
%   输出 -predict_label 测试图片最后标签

%%测试图片读入
%[img_matrix,label] = PredictFaceImread(12);
%faces = size(img_matrix);
%[model,V,mImg,lowvec,upvec] = Train(12);
%对图片矩阵做处理
[m,n]=size(img);
img_matrix=zeros(1,m * n);
img_matrix(1,:)=img(:)'; 
%加载训练模型以及相关数据
load('model');
%%图片降维
%mImg=mean(img_matrix);%求各向量的均值
m=size(img_matrix,1);
%各行减去该行灰度均值
%图像降维
for i=1:m  
    img_matrix(i,:)=img_matrix(i,:)-mImg;  
end  
train_matrix=img_matrix*V;
%%显示特征脸
%visualize(v)%显示主分量脸,即特征脸
%%训练集归一化
%lowvec=min(train_matrix);%当前图片矩阵最小灰度值
%upvec=max(train_matrix);%当前图片矩阵最大灰度值
test_scaledface = scaling(train_matrix,lowvec,upvec);
%进行识别输出识别后的图片标签以及accuray准确率
[predict_label,accuracy,decision_values]=svmpredict(label,test_scaledface,model);