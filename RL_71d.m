clear all

s=zpk('s');

GG1=(s+0.1)/(s*s*(s+3)*(s+8)); HH1=zpk([],[],1);  % System 1. GG1 - forward transfer function, HH1 - feedback transfer function
GG2=((s+0.1)*(s-1.383))/(s*s*(s+3)*(s+8)); HH2=zpk([],[],1);  % System 2. GG2 - forward transfer function, HH2 - feedback transfer function

FF1=GG1*HH1; % Open-loop transfer function (system 1)
FF1
FF2=GG2*HH2; % Open-loop transfer function (system 2)
FF2

% Find zeroes of the closed-loop system
[ZZ_forward1,x,y]=zpkdata(GG1); ZZ_forward1=ZZ_forward1{1}; % System 1
[x,ZZ_feedback1,y]=zpkdata(HH1); ZZ_feedback1=ZZ_feedback1{1};
ZZ1=[ZZ_forward1;ZZ_feedback1];
[ZZ_forward2,x,y]=zpkdata(GG2); ZZ_forward2=ZZ_forward2{1}; % System 2
[x,ZZ_feedback2,y]=zpkdata(HH2); ZZ_feedback2=ZZ_feedback2{1};
ZZ2=[ZZ_forward2;ZZ_feedback2];

figure(2)
h=rlocusplot(FF1,FF2);
p=getoptions(h); % Get options for plot.
p.XLim=[-9,3];
p.YLim=[-10,15];
setoptions(h,p); % Apply options to plot.
sgrid(0.491,0:5:25)
sgrid
legend('System 1','System 2');

hold on   % Plot zeroes of the closed-loop function
plot(real(ZZ2),imag(ZZ2),'ro','MarkerSize',12);
hold off
