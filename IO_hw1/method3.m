function [ betahat ] = method3( beta0,x,y )
%method2 Summary of this function goes here
%   method2 use the fminsearch to slove the OLS minimization program
%   x contains all the independent variables
%   y contains the dependent variables
%   beta0 initial value
f = @(beta,x,y) (y-x*beta)'*(y-x*beta);  % The parameterized function.
hybridopts = optimoptions('fminunc','Algorithm','quasi-newton','MaxFunEvals',1e30); % use the hybrid function option
options = saoptimset('HybridFcn',{@fminunc,hybridopts},'MaxFunEvals',100000); 
         betahat= simulannealbnd(@(beta) f(beta,x,y),beta0,[],[],options);
end


