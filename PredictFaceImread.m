function [img_matrix,label] = PredictFaceImread(n_persons)
%����ͼƬ����
%   ���� -n_persons ����ʶ�����������������
%%���þ����С�Լ���ʼ������
imgrow=200;imgcol=200;
label=zeros(n_persons,1);
img_matrix=zeros(n_persons,imgrow*imgcol);
%%ͼƬ����
for i = 1 : n_persons
    %ͼƬ·�������Լ�ƴ��
    facepath=strcat('C:\Users\����\Desktop\����\����ͼ����\����\fin_img\',num2str(i));  %·����ͬ�������
    cachepath=facepath;
    facepath=cachepath;
    %��¼����ͼƬ��ǩ
    label(i)=i;
    facepath=strcat(facepath,'.bmp');
    %����ͼƬתΪ�Ҷ�ͼ��תΪ��������ֵ��ͼƬ������
    img=imread(facepath);
    img=rgb2gray(img);
    %imshow(img);
    img_matrix(i,:)=img(:)';
end
        
    