
function [pp_unif,s_next,sigma] = uniform_state(s_current,s_next,pp,K,lambda_t,u_t,lambda_f,u_f,sigma)
% clear;
% K=6;

y=K*lambda_t+lambda_f+u_f+K*3*u_t;

%转移概率均匀化
pp_unif = pp;
for i=1 : length(s_next)
    if s_next{i,1} == s_current{1,1} && strcmp(s_next{i,3} , s_current{1,3})
        if s_current{1,2}(1)==s_next{i,2}(1)&&s_current{1,2}(2)==s_next{i,2}(2)&&s_current{1,2}(3)==s_next{i,2}(3)
                pp_unif(i)=1-(1-pp(i))*sigma/y;
        end
    else
        pp_unif(i)= pp(i)*sigma/y;
    end
end