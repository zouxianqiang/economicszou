function TP = fi(theta,P0,P1 )
%UNTITLED23 Summary of this function goes here
%   Detailed explanation goes here
M=11;
J=2;
beta=0.95;
x=(0:10)';
theta12=[-theta(1);-theta(2)];
u0=[x x.^2]*theta12; %utility function when i=0
u1=-theta(3)*ones(11,1); %utility function when i=1
%define conditional transition probability
load cappi.mat
cappi0=cappi(1:11,1:11); %conditional choice prob for i=0
cappi1=cappi(12:22,1:11); %conditional choice prob for i=0
for i=1:M
FUP(:,i)=cappi0(:,i).*P0+cappi1(:,i).*P1;
end
%define the conditional expectation e(a,P)
gamma=0.577;
EAP0=gamma-log(P0);
EAP1=gamma-log(P1);
%define V, value function M*1, mapping from P to V
V=(eye(M)-beta*FUP)\(P0.*(u0+EAP0)+P1.*(u1+EAP1));
%define P, ccp, mapping from V to P
Vtilde=u1-u0+(cappi1-cappi0)*V;
TP0=1./(1+exp(Vtilde)); %M*1, Vtilde is M*1
TP1=exp(Vtilde)./(1+exp(Vtilde));
TP=[TP0, TP1];
end

