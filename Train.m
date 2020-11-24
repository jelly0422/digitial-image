function [model,V,mImg,lowvec,upvec]=Train(nPerson)
%%ʹ��svmѵ���õ�ģ��
%   ����-nPerson ѵ��������
%   ���-model ѵ����ɵ�ģ��
%       -V���ɷַ���
%       -mImg ѵ����ͼƬ������о�ֵ
%       -lowvec ��ǰ��������С�Ҷ�
%       -upvec ��ǰ���������Ҷ�
%%����ͼƬ
[img_matrix,label] = FaceImread(nPerson);
faces = size(img_matrix);
%%ͼƬ��ά
mImg=mean(img_matrix);%��������ľ�ֵ
k=20;%��ͼƬ��20ά
[train_matrix,V]=fastPCA(img_matrix,k,mImg);%��ͼƬ���н�ά�õ���ά���ѵ��������������ɷַ���
%%ѵ������һ��
lowvec=min(train_matrix); 
upvec=max(train_matrix);
train_scaledface = scaling(train_matrix,lowvec,upvec);
%%����ѵ���ĺ˺���Ϊ���Ժ˺���
model = svmtrain(label,train_scaledface,'-t 0');%����svmѵ���õ�ģ��
save('model.mat','model','V','mImg','lowvec','upvec');%��ѵ���õ���ģ���Լ�������Ҫ�õ��ı���������mat�ļ��У�����ʱ��ȡ