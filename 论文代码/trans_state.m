% ״̬ת�ƣ����ݵ�ǰ״̬s_current�͵�ǰ����a�����һ״̬��ת�Ƹ��ʺ��¼�������

function [s_next,pp,sigma] = trans_state(K,s_current,a,lambda_f,u_f,lambda_t,u_t)

% %���Բ���
% clear
% s_current={6,[1,1,1],'D1',0};
% K=6;
% a=-1;
% lambda_f = 20;       %����������
% u_f = 10;                 %�����뿪��
% u_t = 50;                 %�����������
% [lambda_t,~]=satu_delay(s_current{1},a,u_t);

%% ���󵽴�A
%RUȫռ��ʱ���󵽴�ͷ�����������ֹ״̬********************************************************************
if strcmp(s_current{3} , 'A') && a == 0
    if s_current{1}==1     %���RU�����Ƿ�Ϊ1
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
    if s_next6{1}<=2   %���RU�����Ƿ�С��2
        pp6 = 0;
    end
    s_next = [s_next1;s_next2;s_next3;s_next4;s_next5;s_next6];
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    %RUȫռ��ʱ��a=0�ܾ��������ͷ���״̬��ֹ
    for i = 1 : length(s_next)
        pp(i,1) = 0;
    end
    sigma = 0;
    
    %���񵽴�����VFC��1������************************************************************************************
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
        s_next{i,4} = s_next{i,4}-a;    %����״̬������RU������1��
    end
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    
    %���񵽴�����VFC��2������************************************************************************************
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
        s_next{i,4} = s_next{i,4}-a;    %����״̬������RU������2��
    end
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
    
    %���񵽴�����VFC��3������************************************************************************************
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
        s_next{i,4} = s_next{i,4}-a;    %����״̬������RU������3��
    end
    pp = [pp1;pp2;pp3;pp4;pp5;pp6];
end

%% �����뿪
% �����VFC��D1�����뿪************************************************************************************
if strcmp(s_current{3} , 'D1') && a == -1
    if s_current{1,2}(1)>=1     %���״̬�Ƿ�����D1����
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
            s_next{i,4} = s_next{i,4}+1;    %����״̬������RU������1��
        end
    end
    
    % �����VFC��D2�����뿪************************************************************************************
elseif strcmp(s_current{3} , 'D2') && a == -1
    if s_current{1,2}(2)>=1%���״̬�Ƿ�����D2����
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
            s_next{i,4} = s_next{i,4}+2;    %����״̬������RU������2��
        end
    end
    
    % �����VCC��D3�����뿪************************************************************************************
elseif strcmp(s_current{3} , 'D3') && a == -1
    if s_current{1,2}(3)>=1     %���״̬�Ƿ�����D3����
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
            s_next{i,4} = s_next{i,4}+3;    %����״̬������RU������3��
        end
    end
end

%% ��������************************************************************************************
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
        s_next{i,4}=s_next{i,4}+1;  %����״̬������RU������1��
    end
end

%% �����뿪************************************************************************************
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
            s_next{i,4}=s_next{i,4}-1;  %����״̬������RU������1��
        end
        pp = [pp1;pp2;pp3;pp4;pp5;pp6];
        if s_current{4}==0
            for i = 1 : length(s_next)
                pp(i,1) = 0;
            end
        end
end


