
function [lambda_t,T_save,D_access,D_process]=satu_delay1(N,a,u_t)

% function [lambda_t,T_save,D_access,D_process]=satu_delay(s_current,a,u_t)

% % ����N���ͻ����
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
ED = EN*Tslot/1000000;    %��λs

% % ���س���ִ��ʱ��
% L =128;  %L���������ݰ��Ĵ�С500bit������program code��input parameters
% c = 1300*L;     %c�����һ����������Ҫ��CPU������
% f0 = 2.8*10^9;      %f0��һ�����ļ�������0.7/1.5/2GHz��CPU��ʱ��Ƶ�ʣ���ÿ���CPU���ڣ�
% % T_local = c/f0*1000+200;    %ת��Ϊms
% % u_t = a*f0/c;
% 
% %�����ƴ���ʱ��
% % T_process = c/(a*f0)*1000;    %ת��Ϊms


% ����ִ��ʱ��
T_local =0.1;   %��λs

% �󵽴��ʺͽ�ʡʱ��
if a <= 0       %����a=0/-1    %���ݶ�������ƽ��������
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
else    %����a=1/2/3
    D_process = 1/(a*u_t);
%     u_t = f0/c;
%     D_process = c/(a*f0)*1000;    %ת��Ϊms
    D_access = a*ED;  %��λs
    lambda_t = 1/D_access;   %ÿs������������%
    T_save = T_local-D_access-D_process;
end
T_save = T_save*1000;  %ms
% D_access
% D_process
 lambda_t= lambda_t/30;



