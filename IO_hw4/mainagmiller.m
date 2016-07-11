%this is the script for the Agri And Miller
%ZOU,Xianqiang
%{
clear all
clc
global count_new
load Data4.mat
%get the frequency of each combination of x and i
count=zeros(11,2);
for i=0:10
    for j=0:1
        count(i+1,j+1)=sum(Data4(:,1)==i& Data4(:,2)==j);
    end
end
%get the density of each combination of x and i
count_new=reshape(count,[size(count,1)*2,1]);
theta1_0=0.3;
theta2_0=0;
theta3_0=4;
beta=0.95;
options= optimset('MaxFunEvals',1e50,'MaxIter',1000000,'TolFun',1e-500,'TolX', 1.0000e-50);
theta=fminunc(@(theta) AMlikehood(theta,count_new),[theta1_0; theta2_0; theta3_0],options);
%}
clear all
clc

load Data4.mat
%set initial value for conditional choice probability
%ccp0 is the probability of i=1 conditonal on x
ccp0=zeros(11,1);
for i=0:10
        ccp0(i+1,1)=sum(Data4(:,1)==i& Data4(:,2)==1)/sum(Data4(:,1)==i); %the probability of choose i=1
end
P0=1-ccp0; %conditional choice of i=0
P1=1-P0; %conditional choice of i=1, P1=P
for k=1:10
    theta = Maxlikehood( P0, P1 );
    TP=fi(theta,P0,P1);
    TP0=TP(:,1);
    TP1=TP(:,2);
    P0=TP0;
    P1=TP1;
    para(:,k)=theta;
end
fid=fopen('para.txt','w');
for i=1:10
   fprintf(fid, 'v%d      &    %.6f      &    %.6f      &    %.6f   \\\\ \r\n',i,para(:,i));
end
fclose(fid);
    

