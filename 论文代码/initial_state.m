%% 所有状态初始化

function [s] = initial_state(K)

s = {0,[0,0,0],' '};
event = {'A';'D1';'D2';'D3';'F+1';'F-1'};
row = 1;

for M = 1 : K
    for i = 0 : K
        for j = 0 : ceil(K/2)
            for k = 0 : ceil(K/3)
                for e = 1 : length(event)  %赋予6个事件
                    if 1*i+2*j+3*k<=M;%s{row,1}  %第1列表示RU总数，忙碌的要小于等于总数
                        s{row,1} = M;
                        s{row,2}(1) = i;    %被1个RU处理的任务个数
                        s{row,2}(2) = j;    %被2个RU处理的任务个数
                        s{row,2}(3) = k;    %被3个RU处理的任务个数
                        s{row,4} = s{row,1} - (1*i+2*j+3*k);   %第4列表示剩余空闲RU个数
                        
                        %当n1/2/3为0时，没有事件D1/2/3和F1/2/3，去除这些状态
                        if strcmp(event{e},'D1')&&s{row,2}(1)==0
                            continue;
                        end
                        if strcmp(event{e},'D2')&&s{row,2}(2)==0
                            continue;
                        end
                        if strcmp(event{e},'D3')&&s{row,2}(3)==0
                            continue;
                        end
                        
                        %M<=2时，没有事件F-1
                        if s{row,1}<=2&&strcmp(event{e},'F-1')
                            continue;
                        end
                        
                        %M=K时，没有事件F+1
                        if s{row,1}==K&&strcmp(event{e},'F+1')
                            continue;
                        end
                        
                        s{row,3} = event{e};
                        row = row+1;
                    end
                end
            end
        end
    end
end

