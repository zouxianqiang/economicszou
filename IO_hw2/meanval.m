function f= meanval(theta2)
%meanval function use the contraction mapping and an starting value to get
%the mean utility linear part, The basic idea is Given theta2, we get the
%market share, and then iterate the mean utility delta
%   Detailed explanation goes here
global share x2 expmu
%set tolerance level to 1e_15
load mvalold
tol=1e-15;
dis=1;
expmu = exp(mufun(x2,theta2));
while dis>tol
% use the contraction mapping for the loop of meanvalue
expmeanvalue=mvalold.*share./mktshr(mvalold,expmu);
dis=max(abs(expmeanvalue-mvalold));
mvalold=expmeanvalue;
end
f=log(expmeanvalue);


