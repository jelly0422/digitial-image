function [predict_label]=predict(img,label)
%%���Ժ���
%   ���� -img_matrix ����ͼƬ����
%        -label ����ͼƬ��ǩ
%   ��� -predict_label ����ͼƬ����ǩ

%%����ͼƬ����
%[img_matrix,label] = PredictFaceImread(12);
%faces = size(img_matrix);
%[model,V,mImg,lowvec,upvec] = Train(12);
%��ͼƬ����������
[m,n]=size(img);
img_matrix=zeros(1,m * n);
img_matrix(1,:)=img(:)'; 
%����ѵ��ģ���Լ��������
load('model');
%%ͼƬ��ά
%mImg=mean(img_matrix);%��������ľ�ֵ
m=size(img_matrix,1);
%���м�ȥ���лҶȾ�ֵ
%ͼ��ά
for i=1:m  
    img_matrix(i,:)=img_matrix(i,:)-mImg;  
end  
train_matrix=img_matrix*V;
%%��ʾ������
%visualize(v)%��ʾ��������,��������
%%ѵ������һ��
%lowvec=min(train_matrix);%��ǰͼƬ������С�Ҷ�ֵ
%upvec=max(train_matrix);%��ǰͼƬ�������Ҷ�ֵ
test_scaledface = scaling(train_matrix,lowvec,upvec);
%����ʶ�����ʶ����ͼƬ��ǩ�Լ�accuray׼ȷ��
[predict_label,accuracy,decision_values]=svmpredict(label,test_scaledface,model);