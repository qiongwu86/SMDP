
function [V_6next] = find_index(s,i,s_next,N,pp,pp_unif,V_old)
% function [V_6next] = find_index(s,i,s_next,N,pp,V_old)
V_6next = zeros(length(s_next),1);
s_next_index = 1;
                for y = 1: length(s_next)
                    flag = 0;     %�ҵ��¸�״̬��������flag��1
                    for nn = 1: N
                        if s{nn,2}(1)==s_next{y,2}(1)&&s{nn,2}(2)==s_next{y,2}(2)&&s{nn,2}(3)==s_next{y,2}(3)
                            if s{nn,1}==s_next{y,1}&&strcmp(s{nn,3} , s_next{y,3})
                                s_next_index = nn;
                                flag = 1;
                                break;
                            end
                        end
                    end %% �ҵ������Ƿ�Ψһ��Ӧ������
                    if flag == 0 && pp(y)~=0    %���������û���ҵ��¸�״̬�������ͱ���
                        fprintf('��ʼ״̬�ǵ� %d ��\n',i);
                        fprintf('�¸�״̬�ĵ� %d ��\n',y);
                        disp('û���ҵ��¸�״̬������������');
                        disp('************************');
                    end
                    V_6next(y) = pp_unif(y)*V_old(s_next_index);
%                     V_6next(y) = pp(y)*V_old(s_next_index);
                end
                
                