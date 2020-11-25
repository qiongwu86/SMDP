%% ����״̬��ʼ��

function [s] = initial_state(K)

s = {0,[0,0,0],' '};
event = {'A';'D1';'D2';'D3';'F+1';'F-1'};
row = 1;

for M = 1 : K
    for i = 0 : K
        for j = 0 : ceil(K/2)
            for k = 0 : ceil(K/3)
                for e = 1 : length(event)  %����6���¼�
                    if 1*i+2*j+3*k<=M;%s{row,1}  %��1�б�ʾRU������æµ��ҪС�ڵ�������
                        s{row,1} = M;
                        s{row,2}(1) = i;    %��1��RU������������
                        s{row,2}(2) = j;    %��2��RU������������
                        s{row,2}(3) = k;    %��3��RU������������
                        s{row,4} = s{row,1} - (1*i+2*j+3*k);   %��4�б�ʾʣ�����RU����
                        
                        %��n1/2/3Ϊ0ʱ��û���¼�D1/2/3��F1/2/3��ȥ����Щ״̬
                        if strcmp(event{e},'D1')&&s{row,2}(1)==0
                            continue;
                        end
                        if strcmp(event{e},'D2')&&s{row,2}(2)==0
                            continue;
                        end
                        if strcmp(event{e},'D3')&&s{row,2}(3)==0
                            continue;
                        end
                        
                        %M<=2ʱ��û���¼�F-1
                        if s{row,1}<=2&&strcmp(event{e},'F-1')
                            continue;
                        end
                        
                        %M=Kʱ��û���¼�F+1
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

