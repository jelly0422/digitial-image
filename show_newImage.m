function [img,position]=show_newImage(img,img1) %框出照片
%imshow(img);
position=zeros(12,4);
hold on;%原图与下面的框框一起显示
%在人脸的部分画框
    [L,num]=bwlabel(img1,8);%采用标记方法选出图中的白色区域
    stats=regionprops(L,'BoundingBox');%度量区域属性
    n=1;%存放经过筛选以后得到的所有矩形块
    result=zeros(n,4);
    for i=1:num %开始筛选特定区域
    box=stats(i).BoundingBox;
    x=box(1);%矩形坐标X
    y=box(2);%矩形坐标Y
    w=box(3);%矩形宽度w
    h=box(4);%矩形高度h
    result(n,:)=[x y w h];
    n=n+1;
    end
    if size(result,1)==1 && result(1,1)>0 %对可能是人脸的区域进行标记
        rectangle('Position',[result(1,1),result(1,2),result(1,3),result(1,4)],'EdgeColor','r');
    else
        %如果满足条件的矩形区域大于1,则再根据其他信息进行筛选
        for m=1:size(result,1)
            m1=result(m,1);%人脸的横坐标x
            m2=result(m,2);%人脸的纵坐标y
            m3=result(m,3);%人脸的宽度
            m4=result(m,4);%人脸的高度
            if(m3~=m4) %根据人脸于脖子的特征取正方形框
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
