clear;
tic;

%% 初始参数
sita =10;             %RU用完，VFC拒绝时的惩罚
zeta = 18;          %RU用完，车离开时的惩罚
beta = 5;           %节省时延的价格
alpha = 0.1;       %时间折扣因子
iter_max = 100;       %最大迭代次数100
conv = 10^(-3);       %收敛误差
delta = 10;

K =5;                     %RU的总数：4~16
lambda_f =10;       %车辆到达率20
u_f = 10;                 %车辆离开率10
u_t =25;                   %任务服务速率25/50

% 所有状态初始化
[s] = initial_state(K);

N = length(s);   %状态总数
reward = zeros(N,1);
reward_unif = zeros(N,1);
k = zeros(N,1);
V = zeros(N,1);
V_old = zeros(N,1);
Vss = zeros(4,1);
sumpp = zeros(N,1);
action = [-1,0,1,2,3];

%% 值迭代过程
for iter_num = 1 : iter_max
    for i =1: N
        Vss = [-1000;-1000;-1000;-1000;-1000];     %存储4个动作下的值，用于比较选出最大值函数的a
        for x = 1 : length(action)      %遍历所有动作
            a = action(x);
            
            if strcmp(s{i,3},'A') && a<0    %事件为A时，动作a必须大于等于0
                continue;
            end
            
            if ~strcmp(s{i,3},'A') && a>=0  %事件为D1/2/3，动作a必须为-1
                continue;
            end
            
            if a>s{i,4}     %分配给i个车，i不能大于空闲RU总数
                continue;
            end
            
%             [lambda_t,T_save,~]=satu_delay(s(i,:),a,u_t);
            [lambda_t,T_save,~]=satu_delay(s(i,:),a,u_t);
            
            [s_next,pp,sigma] = trans_state(K,s(i,:),a,lambda_f,u_f,lambda_t,u_t);
            
            [pp_unif,s_next,sigma] = uniform_state(s(i,:),s_next,pp,K,lambda_t,u_t,lambda_f,u_f,sigma);
            
            [V_6next] = find_index(s,i,s_next,N,pp,pp_unif,V_old);
            
            %计算该s和a下的最终奖励
            
            % 第一步：计算立即收益k
            if strcmp(s{i,3}, 'A')
                if a == 0   %请求到来，没有空闲RU，VFC拒绝，惩罚
                    k(i) = -sita;
                else       %请求到来，有空闲RU，VFC处理，奖励
                    k(i) = beta*T_save;
                end
            elseif a == -1&&(strcmp(s{i,3}, 'D1')||strcmp(s{i,3}, 'D2')||strcmp(s{i,3}, 'D3')||strcmp(s{i,3}, 'F+1')) %请求离开+车到达
                k(i) = 0;
            elseif a == -1&&strcmp(s{i,3}, 'F-1')
                if s{i,4}==0 %RU全占满时，车辆离开
                    k(i) = -zeta;
                else
                    k(i) = 0;
                end
            end
            
            % 第二步：计算折扣消耗
            b = s{i,2}(1)*1+s{i,2}(2)*2+s{i,2}(3)*3;    %忙碌RU个数
            reward(i) = k(i)-b/(alpha+sigma);   %奖励=立即收益-折扣消耗
            [reward_unif1] = uniform_reward(K,lambda_t,u_t,lambda_f,u_f,reward(i),alpha,sigma);
            reward_unif(i) = reward_unif1;
            [discount_unif] = uniform_discount(K,lambda_t,u_t,lambda_f,u_f,alpha);
            discount =sigma/(alpha+sigma);
%             discount_unif =0;
            conv1 = delta*(1-discount_unif)/(2*discount_unif);
            Vss(x) = reward_unif(i)+discount_unif*sum(V_6next);
            %             Vss(x) = reward(i)+discount*sum(V_6next);
        end     %所有动作循环结束
        
        %根据bellman最优方程，选一个最大的来更新V
        [max_value,max_index] = max(Vss);
        s{i,5} = action(max_index);
        V(i) = max_value;
        sumpp(i)=sum(pp);
    end   %所有状态循环结束
    
    if iter_num>1
        delta_iter = sum(abs(V-V_old))/N;
    end
    V_old = V;    %值函数更新
    
    if (iter_num>1)
        if (delta_iter < conv1)
            break;
        end
    end
end     %所有迭代次数循环计算
toc;

%% 统计行为概率
count = zeros(1,4);
count_prob = zeros(1,4);
for i=1:N
    if s{i,5}==0
        count(1) = count(1)+1;
    elseif s{i,5}==1
        count(2) = count(2)+1;
    elseif s{i,5}==2
        count(3) = count(3)+1;
    elseif s{i,5}==3
        count(4) = count(4)+1;
    end
end
count_prob(1)=count(1)/sum(count);
count_prob(2)=count(2)/sum(count);
count_prob(3)=count(3)/sum(count);
count_prob(4)=count(4)/sum(count);
count_prob

%计算期望奖励，即平均值
rewardSMDP = 0;
for i =1:N
    if strcmp(s{i,3}, 'A')%&&s{i,5}>0
        rewardSMDP = rewardSMDP + V(i,1);
    end
end
% rewardSMDP;

SMDP=rewardSMDP/(sum(count(1)+count(2)+count(3)+count(4)));

