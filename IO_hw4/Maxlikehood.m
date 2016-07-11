function theta = Maxlikehood( P0, P1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
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
theta=fminunc(@(theta) AMlikehood(theta,count_new,P0,P1),[theta1_0; theta2_0; theta3_0],options);


end

