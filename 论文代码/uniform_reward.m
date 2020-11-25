
function [reward_unif] = uniform_reward(K,lambda_t,u_t,lambda_f,u_f,reward,alpha,sigma)

% clear;
% K=6;

y=K*lambda_t+lambda_f+u_f+K*3*u_t;

%½±Àø¾ùÔÈ»¯
reward_unif = reward*(alpha+sigma)/(alpha+y);

