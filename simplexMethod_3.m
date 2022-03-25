clc;
clear all;
A=[1 0 0 1/4 -8 -1 9 ; 0 1 0 1/2 -12 -1/6 3 ; 0 0 1 0 0 1 0];
B=[0 ; 0 ; 1];
c=[0 0 0 -3/4 20 -1/2 6];
[m,n]=size(A);
S=eye(m);
A=[A S B];
bv=n+1:1:n+m;
cost=zeros(1,n+m+1);
cost(1:n)=c;
zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];
simplextable=array2table(zcj);
simplextable.Properties.VariableNames(1:n+m+1)={'x1','x2','x3','x4','x5','x6','x7','s1','s2','s3','sol'}
flag = true;
while(flag)
    zc=zjcj(1:end-1);
    if any(zc<0)
        fprintf('Current BFS is not optimal\n')
        
        [Entering_val,pvt_col]=min(zc);
        if all(A(:,pvt_col)<=0)
            error('LPP is unbounded')
        else
            sol=A(:,end);
            col=A(:,pvt_col);
            n=size(A(:,1));
            for i=1:n
                if col(i)<0
                    ratio(i)= inf;
                else
                    ratio(i)=sol(i) ./ col(i);
                end
            end
            [leaving_val,pvt_row]=min(ratio)
            bv(pvt_row)=pvt_col;
            pvt_key=A(pvt_row,pvt_col);
            A(pvt_row,:)=A(pvt_row,:) ./ pvt_key;
            for i=1:size(A,1)
                if i~=pvt_row
                    A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:)
                end
            end
                zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
     
        end
    else
        flag=false;
    end
end