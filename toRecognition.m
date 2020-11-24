function [face,face_loca]=toRecognition(img,img1) %�ָ�����,������Ժ������С��
face=cell(12,1);%�������ͼƬ
face_loca=zeros(12,2);%face_loca(x,y) x�ǵڼ���ͼ��yΪ1��x���꣬Ϊ2ʱ��y����
[L,num]=bwlabel(img1,8);%���ñ�Ƿ���ѡ��ͼ�еİ�ɫ����
stats=regionprops(L,'BoundingBox');%������������
n=1;%��ž���ɸѡ�Ժ�õ������о��ο�
result=zeros(n,4);
for i=1:num %��ʼɸѡ�ض�����
box=stats(i).BoundingBox;
x=box(1);%��������X
y=box(2);%��������Y
w=box(3);%���ο��w
h=box(4);%���θ߶�h
result(n,:)=[x y w h];
n=n+1;
end
face_num=1;
if size(result,1)==1 && result(1,1)>0 %�Կ�����������������б��
  rectangle('Position',[result(1,1),result(1,2),result(1,3),result(1,4)],'EdgeColor','r');
else
   %������������ľ����������1,���ٸ���������Ϣ����ɸѡ
    for m=1:size(result,1)
        m1=result(m,1);%�����ĺ�����x
        m2=result(m,2);%������������y
        m3=result(m,3);%�����Ŀ��
        m4=result(m,4);%�����ĸ߶�
        if(m3~=m4) %���������ڲ��ӵ�����ȡ�����ο�
            m2=m2+((m4-m3)/2);
            m4=m3;
        end
        face_loca(face_num,1)=m1;
        face_loca(face_num,2)=m2;
            I=imcrop(img,[m1,m2,m3,m4]); %�ָ������
            %��˫���Բ�ֵ����ͼƬ���ط�����200*200
            [IH,IW,ID] = size(I);
            zmf=200/IH;
            ZIH = round(IH*zmf); % �������ź��ͼ��߶ȣ����ȡ��
            ZIW = round(IW*zmf); % �������ź��ͼ���ȣ����ȡ��
            ZI = zeros(ZIH,ZIW,ID); % ������ͼ��
            IT = zeros(IH+2,IW+2,ID);
            IT(2:IH+1,2:IW+1,:) = I;
            IT(1,2:IW+1,:)=I(1,:,:);IT(IH+2,2:IW+1,:)=I(IH,:,:);
            IT(2:IH+1,1,:)=I(:,1,:);IT(2:IH+1,IW+2,:)=I(:,IW,:);
            IT(1,1,:) = I(1,1,:);IT(1,IW+2,:) = I(1,IW,:);
            IT(IH+2,1,:) = I(IH,1,:);IT(IH+2,IW+2,:) = I(IH,IW,:);
            for zj = 1:ZIW         % ��ͼ����а�����Ԫ��ɨ��
                for zi = 1:ZIH
                    ii = (zi-1)/zmf; jj = (zj-1)/zmf;
                    i = floor(ii); j = floor(jj); % ����ȡ��
                    u = ii - i; v = jj - j;
                    i = i + 1; j = j + 1;
                    ZI(zi,zj,:) = (1-u)*(1-v)*IT(i,j,:) +(1-u)*v*IT(i,j+1,:)...
                                + u*(1-v)*IT(i+1,j,:) +u*v*IT(i+1,j+1,:);
                end
            end
            ZI = uint8(ZI); %�õ�����������Ƭ
            face{face_num}=ZI;
            %ֱ��imshow��face{1}��face{12}�Ϳ�����ʾ����ͷ��
            face_num=face_num+1;
    end
end