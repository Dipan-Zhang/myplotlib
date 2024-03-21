%plot
% M = csvread("visuotactile.csv",1,0);
M = readmatrix('visuotactile.csv');
% size(M)
% if M comes with 0 gaps
% M = M(327500:338152,:);
M = M(603600:612700,:);
% for i = 1:size(M,1)/2+1
%     M(i,:) = [];
% end


t = M(:,1);
fx = M(:,2);
fy = M(:,3);
fz = M(:,4);

vx = M(:,5);
vy = M(:,6);
vz = M(:,7);

rx = M(:,8);
ry = M(:,9);
rz = M(:,10);

% figure(1);
% plot(t,fx,t,fy,t,fz);

figure('name', 'filtered');
order = 6;
framelen = 999;
fx = sgolayfilt(fx,order,framelen);
fy = sgolayfilt(fy,order,framelen);
fz = sgolayfilt(fz,order,framelen);
plot(t,fx,t,fy,t,fz);
legend('fx','fy','fz')


figure(3)
lin_vel_norm = sqrt(vx.^2+vy.^2+vz.^2);
lin_vel_norm = sgolayfilt(lin_vel_norm,order,framelen);
ang_vel_norm = sqrt(rx.^2+ry.^2+rz.^2);
ang_vel_norm = sgolayfilt(ang_vel_norm,order,framelen);

plot(t,lin_vel_norm,t,ang_vel_norm,LineWidth=1.5)
legend('lin vel', 'ang vel')

figure('Name','task phase plot')
vz = sgolayfilt(vz,order,framelen);
plot(vz(1:4000),fz(1:4000),LineWidth=1.5)
xlabel('vz')
ylabel('fz')

