function index = mostClose(point,local)
%%获取框起始坐标中与鼠标点击位置坐标最近的坐标
%   输入 -point 鼠标坐标
%        -local 框起始坐标
%   输出 -框起始坐标中与鼠标点击坐标最近的坐标
[x,y]=size(local);
diff=zeros(x,1);
for i = 1 : x 
    diff(i,1)=abs(point(1)-local(i,1))+abs(point(3)-local(i,2));
end
index=find(diff==min(diff));