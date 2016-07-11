function  obj  = newpredict_prob( theta )
%UNTITLED14 Summary of this function goes here
%   this function is to construct the objective function to minimize, I use
%   the one to one mapping of utility and probability
%   we want to choose theta to minimize the distance between delta and
%   deltaU
global delta ccp A

%% compute the expected value function
%generate the sequence for the mileage and investment
%draw one sequence with initial value of (0,0),draw a random variables
%sequence from [0,1], if the draw is larger than the diagnol value of
%tranpro_0, the next period mileage is the same as this period, and after
%get the mileage of next period, we can get replacement decision next
%period according to the ccp matrix, the strategy is the same, draw one
%number from [0,1],if it is larger than certain number in ccp[:,2],then we choose replacement
theta1=theta(1);
theta2=theta(2);
theta3=theta(3);
T=100; %number of time periods
S=10; %number of sequence 
%generate the utility for each period according to the A matrix
B=zeros(T,S);
gamma=0.577;
beta=0.95;
for m=1:11
    for n=1:2
        for j=1:S
        for i=2:T
           B(1,j,m,n)=(A(1,1,j,m,n)*(-theta1)+A(1,1,j,m,n)^2*(-theta2))*(A(1,2,j,m,n)==0)+(-theta3)*(A(1,2,j,m,n)==1);
           B(i,j,m,n)=(beta^i)*(A(i,1,j,m,n)*(-theta1)+A(i,1,j,m,n)^2*(-theta2))*(A(i,2,j,m,n)==0)+(-theta3)*(A(i,2,j,m,n)==1)+gamma-log(ccp(A(i,1,j,m,n)+1,A(i,2,j,m,n)+1));   
        end
       temp(1,j,m,n)=sum(B(:,j,m,n),1);
        end
       V(m,n)=mean(temp(1,:,m,n));
    end
end
diff=V(:,2)-V(:,1);
P=[diff delta];
obj=max(max(dist(P)));
sprintf('%s','complete') 
%expand this Algothrithm and to generate multiple sequence to get the
%% choice specific value function


end



