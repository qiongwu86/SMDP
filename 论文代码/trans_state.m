% 状态转移：根据当前状态s_current和当前动作a求出下一状态、转移概率和事件总速率

function [s_next,pp,sigma] = trans_state(K,s_current,a,lambda_f,u_f,lambda_t,u_t)

% %测试参数
% clear
% s_current={6,[1,1,1],'D1',0};
% K=6;
% a=-1;
% lambda_f = 20;       %车辆到达率
% u_f = 10;                 %车辆离开率
% u_t = 50;                 %请求服务速率
% [lambda_t,~]=satu_delay(s_current{1},a,u_t);

%% 请求到达A
%RU全占满时请求到达，惩罚，丢包，终止状态********************************************************************
if strcmp(s_current{3} , 'A') && a == 0
    if s_current{1}==1     %检查RU总数是否为1
        u_f = 0;
    end
    sigma=s_current{1}*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ s_current{1,2}(3)*3)*u_t+lambda_f+u_f;
    s_next1 = s_current; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
    s_next2 = s_current; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
    s_next3 = s_current; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
    s_next4 = s_current; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
    s_next5 = s_current; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
    if s_next5{1}==K
        pp5 = 0;
    end
    s_next6 = s_current; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
    if s_next6{1}<=2   %检查RU总数是否小于2
        pp6 = 0;
    end
    s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    %RU全占满时，a=0拒绝，给出惩罚，状态终止
    for i = 1 : length(s_next)
        pp(i,1) = 0;
    end
    sigma = 0;
    
    %任务到达，分配给VFC中1个车辆************************************************************************************
elseif strcmp(s_current{3} , 'A') && a == 1
    sigma=s_current{1}*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ s_current{1,2}(3)*3+a)*u_t+lambda_f+u_f;
    s_next1 = s_current; s_next1{1,2}(1)=s_next1{1,2}(1)+1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
    s_next2 = s_current; s_next2{1,2}(1)=s_next2{1,2}(1)+1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
    s_next3 = s_current; s_next3{1,2}(1)=s_next3{1,2}(1)+1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
    s_next4 = s_current; s_next4{1,2}(1)=s_next4{1,2}(1)+1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
    s_next5 = s_current; s_next5{1,2}(1)=s_next5{1,2}(1)+1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
    if s_next5{1}==K
        pp5 = 0;
    end
    s_next6 = s_current; s_next6{1,2}(1)=s_next6{1,2}(1)+1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
    if s_next6{1}<=2
        pp6 = 0;
    end
    s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
    for i=1: length(s_next)
        s_next{i,4} = s_next{i,4}-a;    %更新状态，空闲RU数减少1个
    end
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    
    %任务到达，分配给VFC中2个车辆************************************************************************************
elseif strcmp(s_current{3} , 'A') && a == 2
    sigma=s_current{1}*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ s_current{1,2}(3)*3+a)*u_t+lambda_f+u_f;
    s_next1 = s_current; s_next1{1,2}(2)=s_next1{1,2}(2)+1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
    s_next2 = s_current; s_next2{1,2}(2)=s_next2{1,2}(2)+1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
    s_next3 = s_current; s_next3{1,2}(2)=s_next3{1,2}(2)+1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
    s_next4 = s_current; s_next4{1,2}(2)=s_next4{1,2}(2)+1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
    s_next5 = s_current; s_next5{1,2}(2)=s_next5{1,2}(2)+1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
    if s_next5{1}==K
        pp5 = 0;
    end
    s_next6 = s_current; s_next6{1,2}(2)=s_next6{1,2}(2)+1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
    if s_next6{1}<=2
        pp6 = 0;
    end
    s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
    for i=1: length(s_next)
        s_next{i,4} = s_next{i,4}-a;    %更新状态，空闲RU数减少2个
    end
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    
    %任务到达，分配给VFC中3个车辆************************************************************************************
elseif strcmp(s_current{3} , 'A') && a == 3
    sigma=s_current{1}*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ s_current{1,2}(3)*3+a)*u_t+lambda_f+u_f;
    s_next1 = s_current; s_next1{1,2}(3)=s_next1{1,2}(3)+1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
    s_next2 = s_current; s_next2{1,2}(3)=s_next2{1,2}(3)+1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
    s_next3 = s_current; s_next3{1,2}(3)=s_next3{1,2}(3)+1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
    s_next4 = s_current; s_next4{1,2}(3)=s_next4{1,2}(3)+1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
    s_next5 = s_current; s_next5{1,2}(3)=s_next5{1,2}(3)+1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
    if s_next5{1}==K
        pp5 = 0;
    end
    s_next6 = s_current; s_next6{1,2}(3)=s_next6{1,2}(3)+1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
    if s_next6{1}<=2
        pp6 = 0;
    end
    s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
    for i=1: length(s_next)
        s_next{i,4} = s_next{i,4}-a;    %更新状态，空闲RU数减少3个
    end
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
end

%% 任务离开
% 分配给VFC的D1任务离开************************************************************************************
if strcmp(s_current{3} , 'D1') && a == -1
    if s_current{1,2}(1)>=1     %检查状态是否满足D1请求
        sigma=s_current{1}*lambda_t+(s_current{1,2}(1)-1+s_current{1,2}(2)*2+ s_current{1,2}(3)*3)*u_t+lambda_f+u_f;
        s_next1 = s_current; s_next1{1,2}(1)=s_next1{1,2}(1)-1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
        s_next2 = s_current; s_next2{1,2}(1)=s_next2{1,2}(1)-1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
        s_next3 = s_current; s_next3{1,2}(1)=s_next3{1,2}(1)-1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
        s_next4 = s_current; s_next4{1,2}(1)=s_next4{1,2}(1)-1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
        s_next5 = s_current; s_next5{1,2}(1)=s_next5{1,2}(1)-1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
        if s_next5{1}==K
            pp5 = 0;
        end
        s_next6 = s_current; s_next6{1,2}(1)=s_next6{1,2}(1)-1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
        if s_next6{1}<=2
            pp6 = 0;
        end
        s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
        pp = [pp1;pp2;pp3;pp4;pp5;pp6];
        for i=1: length(s_next)
            s_next{i,4} = s_next{i,4}+1;    %更新状态，空闲RU数增加1个
        end
    end
    
    % 分配给VFC的D2任务离开************************************************************************************
elseif strcmp(s_current{3} , 'D2') && a == -1
    if s_current{1,2}(2)>=1%检查状态是否满足D2请求
        sigma=s_current{1}*lambda_t+(s_current{1,2}(1)+(s_current{1,2}(2)-1)*2+ s_current{1,2}(3)*3)*u_t+lambda_f+u_f;
        s_next1 = s_current; s_next1{1,2}(2)=s_next1{1,2}(2)-1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
        s_next2 = s_current; s_next2{1,2}(2)=s_next2{1,2}(2)-1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
        s_next3 = s_current; s_next3{1,2}(2)=s_next3{1,2}(2)-1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
        s_next4 = s_current; s_next4{1,2}(2)=s_next4{1,2}(2)-1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
        s_next5 = s_current; s_next5{1,2}(2)=s_next5{1,2}(2)-1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
        if s_next5{1}==K
            pp5 = 0;
        end
        s_next6 = s_current; s_next6{1,2}(2)=s_next6{1,2}(2)-1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
        if s_next6{1}<=2
            pp6 = 0;
        end
        s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
        pp = [pp1;pp2;pp3;pp4;pp5;pp6];
        for i=1: length(s_next)
            s_next{i,4} = s_next{i,4}+2;    %更新状态，空闲RU数增加2个
        end
    end
    
    % 分配给VCC的D3任务离开************************************************************************************
elseif strcmp(s_current{3} , 'D3') && a == -1
    if s_current{1,2}(3)>=1     %检查状态是否满足D3请求
        sigma=s_current{1}*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ (s_current{1,2}(3)-1)*3)*u_t+lambda_f+u_f;
        s_next1 = s_current; s_next1{1,2}(3)=s_next1{1,2}(3)-1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
        s_next2 = s_current; s_next2{1,2}(3)=s_next2{1,2}(3)-1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
        s_next3 = s_current; s_next3{1,2}(3)=s_next3{1,2}(3)-1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
        s_next4 = s_current; s_next4{1,2}(3)=s_next4{1,2}(3)-1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
        s_next5 = s_current; s_next5{1,2}(3)=s_next5{1,2}(3)-1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
        if s_next5{1}==K
            pp5 = 0;
        end
        s_next6 = s_current; s_next6{1,2}(3)=s_next6{1,2}(3)-1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
        if s_next6{1}<=2
            pp6 = 0;
        end
        s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
        pp = [pp1;pp2;pp3;pp4;pp5;pp6];
        for i=1: length(s_next)
            s_next{i,4} = s_next{i,4}+3;    %更新状态，空闲RU数增加3个
        end
    end
end

%% 车辆到达************************************************************************************
if strcmp(s_current{3} , 'F+1') && a == -1
    sigma=(s_current{1}+1)*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ s_current{1,2}(3)*3)*u_t+lambda_f+u_f;
    s_next1 = s_current; s_next1{1}=s_next1{1}+1; s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
    s_next2 = s_current; s_next2{1}=s_next2{1}+1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
    s_next3 = s_current; s_next3{1}=s_next3{1}+1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
    s_next4 = s_current; s_next4{1}=s_next4{1}+1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
    s_next5 = s_current; s_next5{1}=s_next5{1}+1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
    if s_next5{1}==K
        pp5 = 0;
    end
    s_next6 = s_current; s_next6{1}=s_next6{1}+1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
    if s_next6{1}<=2
        pp6 = 0;
    end
    s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    for i=1: length(s_next)
        s_next{i,4}=s_next{i,4}+1;  %更新状态，空闲RU数增加1个
    end
end

%% 车辆离开************************************************************************************
if strcmp(s_current{3} , 'F-1') && a == -1
        sigma=(s_current{1}-1)*lambda_t+(s_current{1,2}(1)+s_current{1,2}(2)*2+ s_current{1,2}(3)*3)*u_t+lambda_f+u_f;
        s_next1 = s_current; s_next1{1}=s_next1{1}-1;  s_next1{3} = 'A'; pp1 = s_next1{1}*lambda_t/sigma;
        s_next2 = s_current; s_next2{1}=s_next2{1}-1; s_next2{3} = 'D1'; pp2 = s_next2{1,2}(1)*u_t/sigma;
        s_next3 = s_current; s_next3{1}=s_next3{1}-1; s_next3{3} = 'D2'; pp3 = s_next3{1,2}(2)*2*u_t/sigma;
        s_next4 = s_current; s_next4{1}=s_next4{1}-1; s_next4{3} = 'D3'; pp4 = s_next4{1,2}(3)*3*u_t/sigma;
        s_next5 = s_current; s_next5{1}=s_next5{1}-1; s_next5{3} = 'F+1'; pp5 = lambda_f/sigma;
        if s_next5{1}==K
            pp5 = 0;
        end
        s_next6 = s_current; s_next6{1}=s_next6{1}-1; s_next6{3} = 'F-1'; pp6 = u_f/sigma;
        if s_next6{1}<=2
            pp6 = 0;
        end
        s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
        for i=1: length(s_next)
            s_next{i,4}=s_next{i,4}-1;  %更新状态，空闲RU数减少1个
        end
        pp = [pp1;pp2;pp3;pp4;pp5;pp6];
        if s_current{4}==0
            for i = 1 : length(s_next)
                pp(i,1) = 0;
            end
        end
end


