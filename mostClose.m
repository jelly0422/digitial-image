function index = mostClose(point,local)
%%��ȡ����ʼ�������������λ���������������
%   ���� -point �������
%        -local ����ʼ����
%   ��� -����ʼ��������������������������
[x,y]=size(local);
diff=zeros(x,1);
for i = 1 : x 
    diff(i,1)=abs(point(1)-local(i,1))+abs(point(3)-local(i,2));
end
index=find(diff==min(diff));