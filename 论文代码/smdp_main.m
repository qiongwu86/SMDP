clear;
tic;

%% ��ʼ����
sita =10;             %RU���꣬VFC�ܾ�ʱ�ĳͷ�
zeta = 18;          %RU���꣬���뿪ʱ�ĳͷ�
beta = 5;           %��ʡʱ�ӵļ۸�
alpha = 0.1;       %ʱ���ۿ�����
iter_max = 100;       %����������100
conv = 10^(-3);       %�������
delta = 10;

K =5;                     %RU��������4~16
lambda_f =10;       %����������20
u_f = 10;                 %�����뿪��10
u_t =25;                   %�����������25/50

% ����״̬��ʼ��
[s] = initial_state(K);

N = length(s);   %״̬����
reward = zeros(N,1);
reward_unif = zeros(N,1);
k = zeros(N,1);
V = zeros(N,1);
V_old = zeros(N,1);
Vss = zeros(4,1);
sumpp = zeros(N,1);
action = [-1,0,1,2,3];

%% ֵ��������
for iter_num = 1 : iter_max
    for i =1: N
        Vss = [-1000;-1000;-1000;-1000;-1000];     %�洢4�������µ�ֵ�����ڱȽ�ѡ�����ֵ������a
        for x = 1 : length(action)      %�������ж���
            a = action(x);
            
            if strcmp(s{i,3},'A') && a<0    %�¼�ΪAʱ������a������ڵ���0
                continue;
            end
            
            if ~strcmp(s{i,3},'A') && a>=0  %�¼�ΪD1/2/3������a����Ϊ-1
                continue;
            end
            
            if a>s{i,4}     %�����i������i���ܴ��ڿ���RU����
                continue;
            end
            
%             [lambda_t,T_save,~]=satu_delay(s(i,:),a,u_t);
            [lambda_t,T_save,~]=satu_delay(s(i,:),a,u_t);
            
            [s_next,pp,sigma] = trans_state(K,s(i,:),a,lambda_f,u_f,lambda_t,u_t);
            
            [pp_unif,s_next,sigma] = uniform_state(s(i,:),s_next,pp,K,lambda_t,u_t,lambda_f,u_f,sigma);
            
            [V_6next] = find_index(s,i,s_next,N,pp,pp_unif,V_old);
            
            %�����s��a�µ����ս���
            
            % ��һ����������������k
            if strcmp(s{i,3}, 'A')
                if a == 0   %��������û�п���RU��VFC�ܾ����ͷ�
                    k(i) = -sita;
                else       %���������п���RU��VFC��������
                    k(i) = beta*T_save;
                end
            elseif a == -1&&(strcmp(s{i,3}, 'D1')||strcmp(s{i,3}, 'D2')||strcmp(s{i,3}, 'D3')||strcmp(s{i,3}, 'F+1')) %�����뿪+������
                k(i) = 0;
            elseif a == -1&&strcmp(s{i,3}, 'F-1')
                if s{i,4}==0 %RUȫռ��ʱ�������뿪
                    k(i) = -zeta;
                else
                    k(i) = 0;
                end
            end
            
            % �ڶ����������ۿ�����
            b = s{i,2}(1)*1+s{i,2}(2)*2+s{i,2}(3)*3;    %æµRU����
            reward(i) = k(i)-b/(alpha+sigma);   %����=��������-�ۿ�����
            [reward_unif1] = uniform_reward(K,lambda_t,u_t,lambda_f,u_f,reward(i),alpha,sigma);
            reward_unif(i) = reward_unif1;
            [discount_unif] = uniform_discount(K,lambda_t,u_t,lambda_f,u_f,alpha);
            discount =sigma/(alpha+sigma);
%             discount_unif =0;
            conv1 = delta*(1-discount_unif)/(2*discount_unif);
            Vss(x) = reward_unif(i)+discount_unif*sum(V_6next);
            %             Vss(x) = reward(i)+discount*sum(V_6next);
        end     %���ж���ѭ������
        
        %����bellman���ŷ��̣�ѡһ������������V
        [max_value,max_index] = max(Vss);
        s{i,5} = action(max_index);
        V(i) = max_value;
        sumpp(i)=sum(pp);
    end   %����״̬ѭ������
    
    if iter_num>1
        delta_iter = sum(abs(V-V_old))/N;
    end
    V_old = V;    %ֵ��������
    
    if (iter_num>1)
        if (delta_iter < conv1)
            break;
        end
    end
end     %���е�������ѭ������
toc;

%% ͳ����Ϊ����
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

%����������������ƽ��ֵ
rewardSMDP = 0;
for i =1:N
    if strcmp(s{i,3}, 'A')%&&s{i,5}>0
        rewardSMDP = rewardSMDP + V(i,1);
    end
end
% rewardSMDP;

SMDP=rewardSMDP/(sum(count(1)+count(2)+count(3)+count(4)));

