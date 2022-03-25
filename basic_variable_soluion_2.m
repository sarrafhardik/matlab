clc;
clear;

A = [1 1 -1 3;5 1 4 15];
b=[15;12];
C=[1 2 -1 1];
[m,n]=size(A);
solution=[];
if(n>m)
    nCm=nchoosek(n,m);
    p=nchoosek(1:n,m);
    
    for i=1:nCm
        y=zeros(n,1);
        B = A(:,p(i,:));
        if(det(B)~=0) %This step is correct, but some solutions are lost in
        %the process.
            X=inv(B)*b;
            if(X>=0 & X~=-inf & X~=inf)
                y(p(i,:))=X;
            end
            solution = [solution,y]
        end
    end

else
    fprintf('ncm does not exist');
end

solution = solution';

for i=1: size(solution(:,1))

    obj(i,:)=sum(solution(i,:).*C);
end
P = max(obj)
M = find(obj==P)
OS = solution(M,:);
OS

    