
function [discount_unif] = uniform_discount(K,lambda_t,u_t,lambda_f,u_f,alpha)

% clear;
% K=6;

y=K*lambda_t+lambda_f+u_f+K*3*u_t;

%�ۿ����Ӿ��Ȼ�
discount_unif = y/(y+alpha);

