function [img_matrix,label] = FaceImread(n_persons)
%%��ȡѵ��ͼƬΪ����
%   ���� -n_persons ����
%   ��� -img_matrix ͼƬ����������
%        -label ���е�����ǩ

%ÿһ��ѵ����ͼƬ����
nums=9;
%%ѵ����ͼƬ�ߴ�
imgrow=200;imgcol=200;
label=zeros(n_persons*nums,1);%�����ǩ����
img_matrix=zeros(n_persons*nums,imgrow*imgcol);%����ͼƬ��������
%%ͼƬ����
for i = 1 : n_persons
    facepath=strcat('C:\Users\����\Desktop\����\����ͼ����\����\img2\',num2str(i),'\');%��·��
    cachepath=facepath;
    for j = 1 : nums
        %·���ַ�ƴ��
        facepath=cachepath;
        facepath=strcat(facepath,num2str(j));
        label((i-1)*nums+j)=i;%��ǩ��ֵ
        facepath=strcat(facepath,'.bmp');
        %ͼƬ����
        img=imread(facepath);
        img=rgb2gray(img);
        %imshow(img);%����ͼƬ������
        %��ͼƬ�Ҷ�ֵת����������ֵ�ھ�����
        img_matrix((i-1)*nums+j,:)=img(:)';
    end
end
        
    