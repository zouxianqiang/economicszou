function f = mktshr(mvalold,expmu )
%mktshr use the simulation method to generate the market share for each
%product
%ZOU,Xianqiang
%   To get the computed market share, we sum over the individual's probability
global ns
f=sum(ind_shr(mvalold, expmu),2)./ns;
end

