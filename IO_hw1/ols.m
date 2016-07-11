%% this is OLS estimator by using matlab
%This is the matlab code for hw1, final revision data 2/11/2015
clear
load DATA1.txt;
size(DATA1);
y=DATA1(:,1); %y is the dependent variables, 10000*1
x=DATA1(:,2:21); % x are independent variables 10000*20
format long
ols_betahat = (x'*x)\(x'*y); %this is the beta ols estimator, which is 20*1 matrix
resid=y-x*ols_betahat; %generate the residual for each ind, resid is 10000*1
ssquar=(resid'*resid)/(10000-20); %generate the s^{2}, the degree of freeson is 20
S_kk=diag(inv(x'*x));     % (x'x)^{-1}
variance=ssquar.*S_kk;   %variance of the estimator
se=sqrt(variance);      %standard error of the estimator
z=ols_betahat./se; %the z statistics

% the difficult part is to get the p values or significance level through z
% value
Pval=2*(1-tcdf(abs(z),10000-20-1)); %Pval is the p_value for the 20 estimators

%% print the result using latex format
%print the result to the exp_ols.txt in the format of latex table
fid = fopen('exp_ols.txt','w');
for i=1:20
    if Pval(i)<=0.01
    fprintf(fid, 'v(%d)      &    %.3f $^{***}$ \\\\ \n',i+1,ols_betahat(i));
    fprintf(fid, '           &   (%.3f)  \\\\ \n',se(i));
    else if 0.01<Pval(i)<=0.05
            fprintf(fid, 'v(%d)      &    %.3f $^{**}$ \\\\ \n',i+1,ols_betahat(i));
            fprintf(fid, '           &   (%.3f)  \\\\ \n',se(i));
        else if 0.05<Pval(i)<=0.10
             fprintf(fid, 'v(%d)      &    %.3f $^{*}$ \\\\ \n',i+1,ols_betahat(i));
             fprintf(fid, '           &   (%.3f)  \\\\ \n',se(i));
            else 
                 fprintf(fid, 'v(%d)      &    %.3f \\\\ \n',i+1,ols_betahat(i));
                 fprintf(fid, '           &   (%.3f)  \\\\ \n',se(i));
            end
        end
    end
end




