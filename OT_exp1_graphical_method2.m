
format short
clear all
clc
A = [1 1;0 1; 0 1; 1 -1;1 0];
B=[30;3;12;0;20];
C = [2 3];
solution = [];
x1 = 0:1:max(B);
x2 = (B(1)-A(1,1).*x1)./A(1,2);
x3 = (B(2)-A(2,1).*x1)./A(2,2);
x4 = (B(3)-A(3,1).*x1)./A(3,2);
x5 = (B(4)-A(4,1).*x1)./A(4,2);
x6 = (B(5)-A(5,1).*x1)./A(5,2);

x2 = max(0,x2);
x3 = max(0,x3);
x4 = max(0,x4);
x5 = max(0,x5);
x6 = max(0,x6);

plot(x1,x2,'r',x1,x3,'b',x1,x4,'y',x1,x5,'g',x1,x6,'k');
title('x1 vs x2');
xlabel('x1');
ylabel('x2');
legend('x1+x2=30','x2=3','x2=12','x1-X2=0','x1=20');
grid on

A = [1 1;0 1; 0 1; 1 -1;1 0;1 0;0 1];
B=[30;3;12;0;20;0;0];

for i=1:length(A)%This is the new value of the number of terms. Here it is 6
        A1 = A(i,:);
        B1 = B(i,:);
            for j = i+1 :length(A)      
                A2 = A(j,:);
                B2 = B(j,:);
                A3 = [A1;A2];
                B3 = [B1;B2];
                X = A3\B3;
                solution = [solution X];%stores value of every X as X changes.
            end
end
solution = solution';
solution

x1 = solution(:,1);
x2 = solution(:,2);

H1 = find(x1+x2>30);
solution(H1,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

H2 = find(x2<3);
solution(H2,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

H3 = find(x2>12);
solution(H3,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

H4 = find(x1-x2<0);
solution(H4,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

H5 = find(x1>20);
solution(H5,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

H6 = find(x1<0);
solution(H6,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

H7 = find(x2<0);
solution(H7,:)=[];
x1 = solution(:,1);
x2 = solution(:,2);

for i=1: size(solution(:,1))
    obj(i,:)=sum(solution(i,:).*C)
end

P = max(obj)

M = find(obj==P)

OS = solution(M,:);

OS