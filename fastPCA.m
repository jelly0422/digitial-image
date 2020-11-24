function [pcaA,V] = fastPCA(A,k,mA)  
%快速PCA，主成份分析  
%   输入 A-样本矩阵，每行是一个样本，列是样本的维数  
%        k-降至k维  
%        mA-图像矩阵f_matrix每一列的均值排成一个行向量，即mean(f_matrix)
%   输出 pacA-降维后，训练样本在低维空间中的系数坐标表示 
%        V-主成分分量，即低维空间当中的基  
%%PCA
m=size(A,1);%m为读取图片的张数
Z=(A-repmat(mA,m,1));%中心化样本矩阵
%用中心化的矩阵代替原矩阵
T=Z*Z';
[V1,D]=eigs(T,k);%计算T的最大的k个特征值和特征向量  
V=Z'*V1;%协方差矩阵的特征向量  
%P^-1*（Z*Z')*P=S等价于P^-1*(Z')^-1*Z'*Z*Z'*P=S等价于(Z'*P)^-1*(Z'*Z)*(Z'*P)=S
%P^-1是P的逆矩阵，(Z')^-1为Z'的逆矩阵

%避免像V=Z'*Z这种维数太高的计算。
for i=1:k%特征向量单位化  
    l=norm(V(:,i));%获取最大奇异值 
    V(:,i)=V(:,i)/l;
end  
%单位化后的V是低维空间的基
pcaA=Z*V;%线性变换，降至k维，将中心化的矩阵投影到低维空间的基中，V就是低维空间的基
%pcaA为低维空间的坐标表示，即一个图像的判断依据
end 
