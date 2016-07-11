%this is for computing long-run probability
%ZOU,Xianqiang
%the long-run probability starts from the combination for each x and i, and
%then I can intergrat out the x
%we construct the 22*22 transition matrix at first, consider i as state
%variable
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
load cappi.mat
A=zeros(22);
for m=1:22
    for n=1:22
        A(m,n)=ccp(mod(n,11)+11*(n==11|n==22),2-(n>=11))*cappi(m,mod(n,11)+11*(n==11|n==22));
    end
end
% accordint to transition probability, we can have the stationary
% probability  pi

B=eye(22)-A;
B(22,:)=1;
AR=zeros(22,1);
AR(22,1)=1;
pi=inv(B)* AR;





