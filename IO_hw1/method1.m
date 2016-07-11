function [ betahat ] = method1( beta0,x,y )
%method1 Summary of this function goes here
%   method1 use the fminunc to slove the OLS minimization program
%   x contains all the independent variables
%   y contains the dependent variables
%   beta0 initial value
function [f,g]=myfun(beta,x,y)
f=(y-x*beta)'*(y-x*beta); % the objective function
g=2*x'*x*beta-2*x'*y; % the gradient function
end
options = optimoptions('fminunc','GradObj','on','Algorithm','quasi-newton','MaxIter', 100000,'MaxFunEvals',1e50); 
betahat= fminunc(@(beta) myfun(beta,x,y),beta0,options);
end

