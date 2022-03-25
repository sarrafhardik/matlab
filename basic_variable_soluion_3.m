clc;
clear;

A = [1 0 0 1 0 0 0 ; 0 1 0 0 1 0 0;-1 1 0 0 0 1 0; -1 0 2 0 0 0 1]; %after adding the respective slack and surplus variables
b=[4;4;6;4];
C=[-1 2 -1 0 0 0 0]; %cost coefficients with the required slack variable coefficents

[m,n]=size(A);
solution=[]; %empty array
if(n>m)%number of variables>number of constraints
    nCm=nchoosek(n,m); %all possible combinations of
    p=nchoosek(1:n,m);%from columns 1 to n, we get all possible combinations in pairs of 2. these are the basic variables
    
    for i=1:nCm %loop runs all these cases times.
        y=zeros(n,1); %this ensures that non basic variables are zero
        B = A(:,p(i,:));
        if(det(B)~=0) %This step is correct, but some solutions are lost in
        %the process.
            X=inv(B)*b;
            if(X>=0 & X~=-inf )
                y(p(i,:))=X %entire row gets filled.
                solution = [solution,y] %y column gets added to solution matrix
            end
        end
    end

else
    fprintf('ncm does not exist');
end

solution = solution';

for i=1: size(solution(:,1))%total values in the first row of solutions
    
    obj(i,:)=sum(solution(i,:).*C); %calculating the objective function by element by element multiplication of solutions and cost coefficents
end
P = max(obj)
M = find(obj==P)
OS = solution(M,:);
OS

    