function [img,position]=show_newImage(img,img1) %�����Ƭ
%imshow(img);
position=zeros(12,4);
hold on;%ԭͼ������Ŀ��һ����ʾ
%�������Ĳ��ֻ���
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
            position(m,1)=m1;
            position(m,2)=m2;
            position(m,3)=m3;
            position(m,4)=m4;
            %rectangle('Position',[m1,m2,m3,m4],'EdgeColor','r');
        end
    end
end
