function [ betahat ] = method2( beta0,x,y )
%method2 Summary of this function goes here
%   method2 use the fminsearch to slove the OLS minimization program
%   x contains all the independent variables
%   y contains the dependent variables
%   beta0 initial value
f = @(beta,x,y) (y-x*beta)'*(y-x*beta);  % the objective function
options = optimset('MaxIter', 100000,'MaxFunEvals',1e50);
betahat= fminsearch(@(beta) f(beta,x,y),beta0,options);
end


