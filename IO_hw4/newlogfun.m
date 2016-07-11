function val = newlogfun( theta,count_new)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
tol=1.0e-30; 
gap=tol+1;
%solve the dynamic programming problem
%initial guess of expected value function
%use matrix way to express the iteration
%construct the utility function
x=(0:10)';
theta12=[-theta(1);-theta(2)];
u0=[x x.^2]*theta12;
u1=-theta(3)*ones(11,1);
EV=zeros(11,2);
TEV=zeros(11,2);
iter=0;
beta=0.95;
U=log(exp(u0+beta*EV(:,1))+exp(u1+beta*EV(:,2)));
% transition function could be directly loaded, I construct the transition
% matrix by hand
load cappi.mat
%start from x, and i, the transition function makes sure the state variable
%enter a new state , the utility following the new state y is defines by U
while gap>tol
    TEV(:,1)=cappi(1:11,1:11)*U;
    TEV(:,2)=TEV(1,1);
    gap=max(max(abs(TEV-EV)));
    EV=TEV;
    U=log(exp(u0+beta*EV(:,1))+exp(u1+beta*EV(:,2)));
    iter=iter+1;
end
Pr=exp(u1+beta*EV(:,2))./(exp(u0+beta*EV(:,1))+exp(u1+beta*EV(:,2)));

%% estimate parameters
% construct the likelihood function
%since we had the probability under each state, we could compute the number
%of each state in the data, and get the likelihood
logprob=log([1-Pr',Pr']);
loglike=logprob*count_new;
val=-loglike;
%sprintf('%d',val)
end

