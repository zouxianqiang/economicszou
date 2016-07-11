%this is for the rust's approach
%ZOU,Xianqiang
clear all
clc
global count_new lamda
%% another potential way to compute the lamda, only conditional on i=0
load Data4.mat
TF1=Data4(:,2)==1;
Data4_new=Data4;
Data4_new(TF1,:)=[];
check=Data4_new(:,1)-10;
diff=Data4_new(:,3) - Data4_new(:,1);
sum(diff(:)==0);
lamda=1-(sum(diff(:)==0)- sum(check(:)==0))/size(Data4_new,1); %this is the estimator for lamda
%I am not sure whether should I conditional on i=0 when we estimate the
%lamda
%get the frequency for each combination of x and i
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
theta=fminunc(@(theta) newlogfun(theta,count_new),[theta1_0; theta2_0; theta3_0],options);

