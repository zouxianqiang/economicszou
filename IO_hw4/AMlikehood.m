function obj = AMlikehood( theta, count_new,P0 ,P1 )
%UNTITLED21 Summary of this function goes here
%   Detailed explanation goes here
%This is for the algothrithm provided by Aguirregabiria and Mira
%ZOU,Xianqiang 5/3/2015
%define the elements we need for computation, in this exerice, the
%dimension of choice is 2, and the dimension of state is 11, 
%define conditional choice probability
%initial value of P
TP=fi(theta,P0,P1);
TP0=TP(:,1);
TP1=TP(:,2);
logprob=log([TP0',TP1']);
loglike=logprob*count_new;
obj=-loglike;
%then we need to construct the objective function for minimization
end

