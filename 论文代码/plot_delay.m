clear;
close all;

i = 1;
% Access = zeros(7,3);
% Process = zeros(7,3);
% Backhual = zeros(7,3);
% Save = zeros(7,3);
% LAM= zeros(7,3);

u_t =50;%25和50应该效果较好

for N = 5 : 12
    for a = 1 : 3
        [lambda_t,T_save,D_access,D_process]=satu_delay1(N,a,u_t);
        Access(i,a) = D_access*1000;
        Process(i,a) = D_process*1000;
        Save(i,a) = T_save;
        total_delay(i,a)=D_access*1000+ D_process*1000;
        LAM(i,a) = lambda_t;
%         U(i,a) = u_t;
    end
    i = i + 1;
end

y=[100,100,100,100,100,100,100,100];
x=5:1:12;

% figure;
% subplot(2,2,1)
% plot(x,Process(:,1),'--dm','linewidth',1.5);
% hold on;
% plot(x,Process(:,2),'--sg','linewidth',1.5);
% hold on;
% plot(x,Process(:,3),'--^b','linewidth',1.5);
% hold on;
% 
% xlabel('Maximum number of vehicles in the VFC system \it(K)');
% ylabel('process(ms)');
% % axis([4 16 5 50]);
% legend('a=1, T_{process}','a=2, T_{process}','a=3, T_{process}','Location','NorthWest');
% 
% subplot(2,2,2)
% % figure;
% plot(x,Access(:,1),'--dm','linewidth',1.5);
% hold on;
% plot(x,Access(:,2),'--sg','linewidth',1.5);
% hold on;
% plot(x,Access(:,3),'--^b','linewidth',1.5);
% hold on;
% % plot(x,D_ACCESS(:,4),'--or','linewidth',1.5);
% % hold on;
% xlabel('Maximum number of vehicles in the VFC system \it(K)');
% ylabel('access (ms)');
% % axis([4 16 5 50]);
% legend('action=1','action=2','action=3','Location','NorthWest');

% 
% subplot(2,2,4)
% % figure;
% plot(x,Save(:,1),'--dm','linewidth',1.5);
% hold on;
% plot(x,Save(:,2),'--sg','linewidth',1.5);
% hold on;
% plot(x,Save(:,3),'--^b','linewidth',1.5);
% hold on;
% % plot(x,D_ACCESS(:,4),'--or','linewidth',1.5);
% % hold on;
% xlabel('Maximum number of vehicles in the VFC system \it(K)');
% ylabel('Save time \it(ms)');
% % axis([4 16 5 50]);
% legend('action=1','action=2','action=3','Location','NorthWest');

% subplot(2,2,3)
figure;
plot(x,LAM(:,1),'--sb','linewidth',1.5);
hold on;
plot(x,LAM(:,2),'--^m','linewidth',1.5);
hold on;
plot(x,LAM(:,3),'--or','linewidth',1.5);
hold on;
% plot(x,D_ACCESS(:,4),'--or','linewidth',1.5);
% hold on;
xlabel('Maximum number of vehicles in the VFC system \it(K)');
ylabel('Task arrival rate ({\it/s})');
% axis([4 16 5 50]);
legend('Action 1','Action 2','Action 3','Location','NorthWest');


figure;
plot(x,total_delay(:,1),'--sb','linewidth',1.5);
hold on;
plot(x,total_delay(:,2),'--^m','linewidth',1.5);
hold on;
plot(x,total_delay(:,3),'--or','linewidth',1.5);
hold on;
plot(x,y,'--g','linewidth',2.5);
hold on;
xlabel('Maximum number of vehicles in the VFC system ({\itK})');
ylabel('Delay of offloading a task ({\itms})');
axis([5 12 0 110]);
legend('Action 1','Action 2','Action 3','Maximum delay limit','Location','NorthWest');

% figure;
% plot(x,Save(:,1),'--dm','linewidth',1.5);
% hold on;
% plot(x,Save(:,2),'--sg','linewidth',1.5);
% hold on;
% plot(x,Save(:,3),'--^b','linewidth',1.5);
% hold on;
% xlabel('Maximum number of vehicles in the VFC system');
% ylabel('Save time (ms)');
% % axis([4 16 5 50]);
% legend('action=1','action=2','action=3','Location','NorthWest');
