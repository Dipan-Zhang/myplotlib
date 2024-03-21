%plot
addpath("exp0408")

M= readmatrix('exp0408/exp0408_15N_fast/ff.csv');
% size(M)
% if M comes with 0 gaps
% M = M(327500:338152,:);
% M = M(604700:612700,:);
% for i = 1:size(M,1)/2+1
%     M(i,:) = [];
% end

head = 100;
% tail = 74000;
tail = size(M,1);
ka = 0.06;
kb = 10;


t = M(head:tail,1);
rho = M(head:tail,2);
rho_rate = M(head:tail,3);
rho_dot = M(head:tail,4);
energy = M(head:tail,6);
max_eng = M(1,5); max_energy = max_eng*ones(size(energy));
angleError = M(head:tail,7);
localCurvature = M(head:tail,8);
x = M(head:tail,9);
y = M(head:tail,10);
z = M(head:tail,11);
xd = M(head:tail,12);
yd = M(head:tail,13);
zd = M(head:tail,14);
fd = M(head:tail,15);
ext_force_x = M(head:tail,16);
ext_force_y = M(head:tail,17);
ext_force_z= M(head:tail,18);
ext_force_tx= M(head:tail,19);
ext_force_ty= M(head:tail,20);
ext_force_tz= M(head:tail,21);
vx = M(head:tail,22);
vy = M(head:tail,23);
vz = M(head:tail,24);
v1 = M(head:tail,25);
v2 = M(head:tail,26);
v3 = M(head:tail,27);
% Energy
% figure(1)
% plot(t,energy,'b');
% hold on;
% plot(t, max_energy,"r");
% title('Current Energy')
% hold off

% Energy
angle_abs = ka * angleError;
% local curvature term
localCurvature_abs = kb* localCurvature ; %works as a certain offset
% fx*x_tilde term
externel_abs  = energy - angle_abs - localCurvature_abs ;
figure(2)
plot(t,angle_abs,'r');
hold on
plot(t,localCurvature_abs,'g');
plot(t,externel_abs,'b');
plot(t,energy,'k','LineWidth',1);
plot(t, max_energy,'color',[0.4940 0.1840 0.5560],'LineWidth',2);
title('Abs values error terms')
xlabel('time/s') 
ylabel('Error') 
legend({'angle error','local curvature','external force','total energy','max energy'});
hold off


% Position error
figure(3);
plot(t,x);
hold on
plot(t,xd);
hold on 
plot(t,y);
hold on
plot(t,yd)
hold on
plot(t,z);
hold on
plot(t,zd);
title('Position Tracking')
legend({'x','xd','y','yd',',z','zd'});
hold off;

figure(4)
plot(t,rho,'LineWidth',2);
hold on 
plot(t,rho_rate,'b');
plot(t,rho_dot,'r');
title('Rho')
axis([-inf inf 0 2])
legend({'rho','rho rate ','rho dot'});
hold off 