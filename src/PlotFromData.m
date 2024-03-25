%load DataWithoutObserver_SensorsData.mat  % Data from sensors
%load DataWithoutObserver_EstimatedData.mat % Data estimated by the observer
%load DataWithoutObserver_Commands.mat % Commands

load SwingAndControl_Data.mat % Data from the sensors with the swing up
load SwingAndControl_Commands.mat % Commands data with the swing up

Ts=0.01;
time=0:Ts:(length(Data(:,1))-1)*Ts;

%%% Plot the experiment (input and output).
% figure
% plot(time,Data(:,1),time,DataCommands(:));
% title('position');
% 
% figure
% plot(time,Data(:,2),time,DataCommands(:));
% title('velocity');
% 
% figure
% plot(time,Data(:,3)-Data(1,3),time,DataCommands(:));
% title('angle');
% 
% figure
% plot(time,Data(:,4),time,DataCommands(:));
% title('angle velocity');


%%% Plot all in the same figure
figure
grid on;
plot(time,DataCommands(:),'m');
hold on
plot(time,Data(:,1),'b');
hold on
plot(time,Data(:,2),'c');
hold on
plot(time,Data(:,3),'r');
hold on
plot(time,Data(:,4),'g');
title('Sensors')
legend('position','velocity','angle','angle velocity')

% figure
% grid on;
% % plot(time,DataCommands(:),'m');
% % hold on
% plot(time,Data_e(:,1),'b');
% hold on
% plot(time,Data_e(:,2),'c');
% hold on
% plot(time,Data_e(:,3),'r');
% hold on
% plot(time,Data_e(:,4),'g');
% title('Observer')
% legend('position','velocity','angle','angle velocity')
