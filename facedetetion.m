function [img,result]=facedetetion(img)
% imgΪ����ͼ��
% resultΪ��������õ��Ķ�ֵͼ

y=rgb2ycbcr(img);
[r,c,l]=size(y);
cb=double(y(:,:,2)); %�õ�ͼ���Cb����
cr=double(y(:,:,3)); %�õ�ͼ���Cr����
%����ÿ�����ص�ķ�ɫ����
p=zeros(r,c);
for i=1:r
    for j=1:c
        w=[cb(i,j) cr(i,j)]; %ɫ�Ⱦ���
        m=[123.4516 147.5699]; %��ɫ��ֵ
        n=[97.0916 23.3700;23.3700 137.9966]; %Э������󣬶�Ӧ�˴���ɢ��˹�ֲ�
        p(i,j)=exp((-0.5)*(w-m)*inv(n)*(w-m)'); %�����ɫ���ʣ������ƶ�
    end
end
binaryImage=p./max(max(p));%��һ�����
%���濪ʼ��ֵ��
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

%����ѧ��̬ѧ����
se=strel('square',6);
binaryImage=imopen(binaryImage,se); %������,�Ͽ���խ������
%figure;subplot(141);imshow(binaryImage);
binaryImage=imclose(binaryImage,se); %�����㣬���խ��ȱ�ڣ���С��
%subplot(142);imshow(binaryImage);
binaryImage=imfill(binaryImage,'holes');%�
%subplot(143);imshow(binaryImage);
se1=strel('square',9); 
binaryImage=imopen(binaryImage,se1); %�ô�һ��ĽṹԪ���п�����,�Ͽ���խ������
%subplot(144);imshow(binaryImage);

%�޳���̬ѧ�ϲ��������Ĳ���
[result,num]=bwlabel(binaryImage,4);%��ͨ��
Area=[];
for i=1:num %���ݰ�ɫ���򳤿�����޳�������
[r,c]=find(result==i);
row=max(r)-min(r);%����߶�
col=max(c)-min(c);%������
temp=size(r);
if(row/col>2.2)||(row/col<0.8) %�ж��Ƿ���ϳ���ȷ�Χ
for k=1:temp
result(r(k),c(k))=0; %�޳����ֽ���Щ�ǳ����Ŀ�ķ�����
end
else
Area(end+1)=row*col;
continue;
end
end

%�޳�������С�ܶ�Ĳ���
[result,num]=bwlabel(result);
B=regionprops(result,'area');
Se=[B.Area];
avg_Se=mean(Se(:));
for i=1:num
[r,c]=find(result==i);
n_area=Se(i);
if (n_area/avg_Se<0.65)
for k=1:size(r)
result(r(k),c(k))=0; %�޳����������С�ܶ�ķ���������
end
else
continue;
end
end
end