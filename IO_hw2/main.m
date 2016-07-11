% this is the main function which load the data and use the function to get
% the estimation result
% Written by ZOU,Xianqiang, starting from 3/7/1015
% Estimation of Random Coefficient Model using Automobile data
clear all
clc
close all
%include certain gloable variables  
global invA ns x1 x2 IV vfull cdid cdindex share theta1
%% load the data: load the data: the key variables we want to are market share
%and prices, observed product characteristics and IVs for GMM estimation
%from excel file
load format.txt

%define the market share data and IV data for use, and baseline parameters for the model, like market number, brand number
IV1=format(:,4);
IV2=format(:,7);
IV3=format(:,9);
IV4=format(:,11);
IV5=format(:,13);
IV6=format(:,15);
pr=format(:,5);
Dummy=format(:,19:44);
IV=[IV1,IV2,IV3,IV4,IV5,IV6,Dummy];
tem_x1=[pr,IV1,IV2,Dummy]; %include all the dummies, hence no need to add an constant term, and also no need to add product characteristics variables based on Nevo's note
x1=sparse(tem_x1);
x2=[IV1,IV2]; % don't include constant term, only two terms have random coefficients
clearvars IV1 IV2 IV3 IV4 IV5 IV6
%the weighting matrix
invA = inv(IV'*IV);

nmkt=8; %no of the market is 8, from 91 to 98, each year forms a market
ns=150;  %the no of observation for random draws is set to 30

%% create index as nevo's code

cdindex=[76,75,74,86,86,90,89,92]; % the number of observation in each market, here market is defined by year
cdid=[ones(1,cdindex(1)),2*ones(1,cdindex(2)),3*ones(1,cdindex(3)),4*ones(1,cdindex(4)),5*ones(1,cdindex(5)),6*ones(1,cdindex(6)),7*ones(1,cdindex(7)),8*ones(1,cdindex(8))]';
% give each market an market indicator

% v draw from multivariate normal distribution,
mu=zeros(ns*size(x2,2),1);
sigma=eye(ns*size(x2,2));
%v=mvnrnd(mu,sigma,nmkt); 
%save vdraw.mat v
load('vdraw.mat', 'v')
vfull = v(cdid,:);


%market share data,format contains all the dataset transfered from dta
share=format(:,16);
outshare=format(:,18);

%run the logit regression model to get the initial value for the mean
%utility
mean=log(share)-log(outshare);
theta_0=(x1'*x1)\x1'*mean;
xi=mean-x1*theta_0;
mean_0=x1*theta_0;

%use the initial value for mean utility to start the loop to compute the
%market share
%use the second method: do the exponential transformation
mvalold=exp(mean_0);
save mvalold mvalold
clear mvalold
%% use the fminsearch function to search for the optimal parameters
%theta1 is the parameters for linear part
%theta2 is the parameters for nonlinear part, because we only have two
%variables which have random coefficients, then the dimension of theta2 is2
%define the objective function gmmobj in other m file
%starting value, only for theta2, utilize the separation between linear
%part and non-linear part
theta2_0=[0,0]'; %start with zero vector
%I also try a lot of another starting values, the results are quite
%sensitive to the starting values 
options = optimset('MaxFunEvals',1e30,'MaxIter',100000);
tic
theta2=fminsearch(@(theta2) mygmm(theta2),theta2_0,options);
toc
fprintf(fid,'%12.8f  %12.8f\n\n',theta2);
%the results are quite different each time they run, this might because of
%the random draw of multivariate distribution is quite different each time.

%print out the results
fid = fopen('exp.txt','a');
fprintf(fid,'%12.8f  %12.8f\n\n',theta2);
fclose(fid);

% I could also fixed the random draw, and try different initial value of
% theta2, and see how does the results change

%% use theta2 to compute theta1, and then compute own and cross price
%elasticity
%because there is no random coefficient for price, the alpha_{i)=alpha
alpha=theta1(1);
delta=meanval(theta2);
expdelta=exp(delta);
expmu = exp(mufun(x2,theta2));
ind_share=ind_shr(expdelta,expmu );
load mvalold
maket_share=sum(ind_shr(mvalold, expmu),2)./ns;
% And we only need keep the ind_share for the ten desired automobiles.
% To identify the 10 automobiles from 1995, I choose the first automobile
% in 1995, the serial no is 312-321 in the format.mat
% define the vector of price for the ten automobile

pr10=pr(312:321,:);
share10=share(312:321,:);
ind_share10=ind_share(312:321,:);
other_ind_share10=1-ind_share10;
prela=zeros(10,10);
for i=1:10
        for j=1:10
            if i==j
                prela(i,j)=alpha*ind_share10(i,:)*other_ind_share10(i,:)'*(pr10(i)/(share10(i)*ns));
            else
                prela(i,j)=-alpha*ind_share10(i,:)*ind_share10(j,:)'*(pr10(j)/(share10(i)*ns));
            end
        end
end
fid=fopen('prela.txt','w');
for i=1:10
   fprintf(fid, 'v%d      &    %.6f      &    %.6f      &    %.6f      &    %.6f      &    %.6f      &    %.6f      &    %.6f      &    %.6f      &    %.6f     &    %.6f \\\\ \r\n',i,prela(i,:));
end
fclose(fid);

%% For question(c), we need to keep all the samples in 1995, which is 86 automobiles
pr95=pr(312:397,:);
share95=share(312:397,:);
ind_share95=ind_share(312:397,:);
other_ind_share95=1-ind_share95;
load frm.txt
firm=frm(:,1);
parder=zeros(86,86);
% We get all the data from 1995, to get the partial derivative, we need
% to change the above formula a little
for i=1:86
        for j=1:86
            if i==j
                parder(i,j)=-alpha*ind_share95(i,:)*other_ind_share95(i,:)'*(pr95(i)/(pr95(j)*ns));
            elseif i~=j && firm(i)==firm(j)
                parder(i,j)=alpha*ind_share95(i,:)*ind_share95(j,:)'/ns;
            else
                parder(i,j)=0;
            end
        end
end
markup=parder\share95;
margincost=pr95-markup;
% with the markup, we should sort the automobiles according to the number
% of markup and then get the top 5 and worst 5, We use the stata to list
% the results.







