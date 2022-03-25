clc;
clear all;
A=[1 4 8 6;4 1 2 1;2 3 1 2];
B=[11;7;2];
c=[4 6 3 1]; %cost  vector
[m,n]=size(A); % m corresponds to number of varibales, and n corresponds to number variable si n the constraints
S=eye(m); %since there are 3 constraints, means that we need 3 slack variables.
A=[A S B]; %value of A is updated.
bv=n+1:1:n+m; %initial basic variables are s1, s2, s3. So from n+1 to n+m
cost=zeros(1,n+m+1); % +1 accouns for the RHS
cost(1:n)=c; % as n corresponds to the number of variables, then corresponding to that, the cost vector is updated.
zjcj=cost(bv)*A-cost; 
zcj=[zjcj;A]; %zjcj will be the first row and A is remaining rows of the matrix. Hence a new matrix is made.
simplextable=array2table(zcj);%the first table gets made 
simplextable.Properties.VariableNames(1:n+m+1)={'x1','x2','x3','x4','s1','s2','s3','sol'}
flag = true; %setting a flag for later use.
while(flag)
    zc=zjcj(1:end-1);%another variable is taken without consider the last solution column.
    if any(zc<0) %if any element is less than 0 then the solution is not optimal for maximization problem
        fprintf('Current BFS is not optimal\n')
        
        [Entering_val,pvt_col]=min(zc); %the most negative value is taken and 
        % the corresponding variable becomes the enteringn variable.
        % pvt_col stores the column
        if all(A(:,pvt_col)<=0)%all terms under that column
            error('LPP is unbounded') %if all the scalars are less than or equa to zero, then lpp has unbounded solution even though  it lies in feasible region
        else %this finds the new optimal solutions as the BFS is not optimal
            sol=A(:,end) %selects the entire solution  column
            col=A(:,pvt_col) %selects the pivot column with the most negative value of zj-zj
            n=size(A(:,1)) %size of the first column
            for i=1:n
                if col(i)<0
                    ratio(i)= inf;
                else
                    ratio(i)=sol(i) ./ col(i); %storing the values of ratio inside the ratio array
                end
            end
            [leaving_val,pvt_row]=min(ratio) %we select the pivot row
            bv(pvt_row)=pvt_col;
            pvt_key=A(pvt_row,pvt_col); %pivot element
            A(pvt_row,:)=A(pvt_row,:) ./ pvt_key; %divide every element of pivot row by pivot element
            for i=1:size(A,1)
                if i~=pvt_row
                    A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:)  %these are the elementary row operations
                end
            end
                zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
     
        end
    else
        flag=false;
    end
end