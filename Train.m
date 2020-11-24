function [model,V,mImg,lowvec,upvec]=Train(nPerson)
%%使用svm训练得到模型
%   输入-nPerson 训练的人数
%   输出-model 训练完成的模型
%       -V主成分分量
%       -mImg 训练的图片矩阵各行均值
%       -lowvec 当前矩阵中最小灰度
%       -upvec 当前矩阵中最大灰度
%%读入图片
[img_matrix,label] = FaceImread(nPerson);
faces = size(img_matrix);
%%图片降维
mImg=mean(img_matrix);%求各向量的均值
k=20;%将图片降20维
[train_matrix,V]=fastPCA(img_matrix,k,mImg);%对图片进行降维得到降维后的训练样本矩阵和主成分分量
%%训练集归一化
lowvec=min(train_matrix); 
upvec=max(train_matrix);
train_scaledface = scaling(train_matrix,lowvec,upvec);
%%设置训练的核函数为线性核函数
model = svmtrain(label,train_scaledface,'-t 0');%调用svm训练得到模型
save('model.mat','model','V','mImg','lowvec','upvec');%将训练得到的模型以及各个需要用到的变量保存在mat文件中，测试时读取