function [face,face_loca]=toRecognition(img,img1) %分割人脸,放入测试和下面的小框
face=cell(12,1);%存放人脸图片
face_loca=zeros(12,2);%face_loca(x,y) x是第几张图，y为1是x坐标，为2时是y坐标
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
face_num=1;
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
        face_loca(face_num,1)=m1;
        face_loca(face_num,2)=m2;
            I=imcrop(img,[m1,m2,m3,m4]); %分割出人脸
            %用双线性插值法把图片像素放缩成200*200
            [IH,IW,ID] = size(I);
            zmf=200/IH;
            ZIH = round(IH*zmf); % 计算缩放后的图像高度，最近取整
            ZIW = round(IW*zmf); % 计算缩放后的图像宽度，最近取整
            ZI = zeros(ZIH,ZIW,ID); % 创建新图像
            IT = zeros(IH+2,IW+2,ID);
            IT(2:IH+1,2:IW+1,:) = I;
            IT(1,2:IW+1,:)=I(1,:,:);IT(IH+2,2:IW+1,:)=I(IH,:,:);
            IT(2:IH+1,1,:)=I(:,1,:);IT(2:IH+1,IW+2,:)=I(:,IW,:);
            IT(1,1,:) = I(1,1,:);IT(1,IW+2,:) = I(1,IW,:);
            IT(IH+2,1,:) = I(IH,1,:);IT(IH+2,IW+2,:) = I(IH,IW,:);
            for zj = 1:ZIW         % 对图像进行按列逐元素扫描
                for zi = 1:ZIH
                    ii = (zi-1)/zmf; jj = (zj-1)/zmf;
                    i = floor(ii); j = floor(jj); % 向下取整
                    u = ii - i; v = jj - j;
                    i = i + 1; j = j + 1;
                    ZI(zi,zj,:) = (1-u)*(1-v)*IT(i,j,:) +(1-u)*v*IT(i,j+1,:)...
                                + u*(1-v)*IT(i+1,j,:) +u*v*IT(i+1,j+1,:);
                end
            end
            ZI = uint8(ZI); %得到最终人脸照片
            face{face_num}=ZI;
            %直接imshow出face{1}到face{12}就可以显示出认头了
            face_num=face_num+1;
    end
end