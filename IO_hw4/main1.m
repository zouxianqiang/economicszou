%this main file is for the Hotz and Miller's algothrithm
%created by ZOU,Xianqiang 5/2/2015
clear all
clc

global ccp0 delta ccp lamda A
load Data4.mat
%set initial value for conditional choice probability
%ccp0 is the probability of i=1 conditonal on x
ccp0=zeros(11,1);
delta=zeros(11,1);
for i=0:10
        ccp0(i+1,1)=sum(Data4(:,1)==i& Data4(:,2)==1)/sum(Data4(:,1)==i); %the probability of choose i=1
        delta(i+1,1)=log(ccp0(i+1,1))-log(1-ccp0(i+1,1));
end
ccp=[ccp0,1-ccp0]; %condtional prob of choose i=1 and i=0
lamda=0.8151;
%draw the sequence to compute the choice specific value function
%the draw matrix dimension is T*22*J*M*N
%this method is wrong for now,need some revision
T=100; %number of time periods
S=10; %number of sequence 
Draw=rand(T,S);
Draw1=rand(11,T,S);
A=zeros(T,2,S,10,2); %store the draw sequence in this matrix, the dimension of each sequence is T*2, with S sequence
for m=1:11
     for n=1:2
    A(1,1,:,m,n)=m-1;
    A(1,2,:,m,n)=n-1;
    for i=1:(T-1)
        for j=1:S
        temp(j,m,n)=(Draw(i,j)>1-lamda);
        A(i+1,1,j,m,n)=temp(j,m,n)+A(i,1,j,m,n)*(1-A(i,2,j,m,n));
          if A(i+1,1,j,m,n)==11
           A(i+1,1,j,m,n)=10;
          end       
          A(i+1,2,j,m,n)=(Draw1(A(i+1,1,j,m,n)+1,i,j)<ccp0(A(i+1,1,j,m,n)+1,1));
        end
     end
    end
end
%% minimize the objective function we construct in predict_prob function  
options = optimset('MaxFunEvals',1e30,'MaxIter',100000,'TolX', 1.0000e-50);
theta=fminunc(@(theta) newpredict_prob(theta),[0.3;0;4],options);
fid = fopen('exp.txt','w');
fprintf(fid,'%12.8f  %12.8f %12.8f\n\n',theta);


