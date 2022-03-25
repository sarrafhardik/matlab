clc;
% clear all;
% A=[-1 1; 1 1];
% B=[1;2];
% c=[1 2];
 m=3; n=5; %no. of variables and m is no. of equations
% S=eye(m);
cost=[3 2 0 0 -100 0];
A=[1 1 1 0 0 2; 1 3 0 1 0 3; 1 -1 0 0 1 1 ];
bv=[3 4 5];%columns of bv

[m,n]=size(A);

zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];
bigMtable=array2table(zcj);
bigMtable.Properties.VariableNames(1:6)={'x1','x2','s1','s2','a1','sol'} %6 variables
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
            [leaving_val,pvt_row]=min(ratio);
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