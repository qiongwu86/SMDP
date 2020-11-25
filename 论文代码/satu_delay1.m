
function [lambda_t,T_save,D_access,D_process]=satu_delay1(N,a,u_t)

% function [lambda_t,T_save,D_access,D_process]=satu_delay(s_current,a,u_t)

% % 根据N求冲突概率
% s_current = {10,[2,1,1],'A'};
% a = 0;
% u_t = 30;

W = 3;
m = 1;
% N =s_current{1,1};

[p,Tslot] = satu_iteration(N,W,m,a);

EN1=(1-(m+1)*p^m+m*p^(m+1))/(2*(1-p))+((1-p)*(1-(2*p)^m)*W)/(1-2*p)-(1-p^m)*W/2;
EN2=0.5*(p^m)*(m+(2^m-1)*W+(2^m*W+1)/(1-p));
EN = (EN1 + EN2);
ED = EN*Tslot/1000000;    %单位s

% % 本地车辆执行时间
% L =128;  %L是输入数据包的大小500bit，包括program code和input parameters
% c = 1300*L;     %c是完成一个任务所需要的CPU周期数
% f0 = 2.8*10^9;      %f0是一个车的计算能力0.7/1.5/2GHz（CPU的时钟频率，即每秒的CPU周期）
% % T_local = c/f0*1000+200;    %转换为ms
% % u_t = a*f0/c;
% 
% %车载云处理时间
% % T_process = c/(a*f0)*1000;    %转换为ms


% 本地执行时间
T_local =0.1;   %单位s

% 求到达率和节省时延
if a <= 0       %动作a=0/-1    %根据动作计算平均到达率
    a_total=s_current{1,2}(1)+s_current{1,2}(2)+s_current{1,2}(3);
    if a_total==0
        p1=1/3;
        p2=1/3;
        p3=1/3;
%         pt1=0;
%         pt2=0;
%         pt3=0;
    else
        p1=s_current{1,2}(1)/a_total;
        p2=s_current{1,2}(2)/a_total;
        p3=s_current{1,2}(3)/a_total;
%         pt1=s_current{1,2}(1)/a_total;
%         pt2=s_current{1,2}(2)/a_total;
%         pt3=s_current{1,2}(3)/a_total;
    end
%     u_t1 = 1*f0/c;
%     u_t2 = 2*f0/c;
%     u_t3 = 3*f0/c;
%     u_t = pt1*u_t1+pt2*u_t2+pt3*u_t3;
    
    lam1 = 1/(ED);
    lam2 = 1/(2*ED);
    lam3 = 1/(3*ED);
    lambda_t = p1*lam1+p2*lam2+p3*lam3;
    D_process = 0;
    D_access = 0;
    T_save = 0;
else    %动作a=1/2/3
    D_process = 1/(a*u_t);
%     u_t = f0/c;
%     D_process = c/(a*f0)*1000;    %转换为ms
    D_access = a*ED;  %单位s
    lambda_t = 1/D_access;   %每s到达的请求个数%
    T_save = T_local-D_access-D_process;
end
T_save = T_save*1000;  %ms
% D_access
% D_process
 lambda_t= lambda_t/30;



