
function [V_6next] = find_index(s,i,s_next,N,pp,pp_unif,V_old)
% function [V_6next] = find_index(s,i,s_next,N,pp,V_old)
V_6next = zeros(length(s_next),1);
s_next_index = 1;
                for y = 1: length(s_next)
                    flag = 0;     %找到下个状态的索引后flag置1
                    for nn = 1: N
                        if s{nn,2}(1)==s_next{y,2}(1)&&s{nn,2}(2)==s_next{y,2}(2)&&s{nn,2}(3)==s_next{y,2}(3)
                            if s{nn,1}==s_next{y,1}&&strcmp(s{nn,3} , s_next{y,3})
                                s_next_index = nn;
                                flag = 1;
                                break;
                            end
                        end
                    end %% 找的索引是否唯一对应？？？
                    if flag == 0 && pp(y)~=0    %如果遍历后没有找到下个状态索引，就报错
                        fprintf('初始状态是第 %d 个\n',i);
                        fprintf('下个状态的第 %d 个\n',y);
                        disp('没有找到下个状态的索引！！！');
                        disp('************************');
                    end
                    V_6next(y) = pp_unif(y)*V_old(s_next_index);
%                     V_6next(y) = pp(y)*V_old(s_next_index);
                end
                
                