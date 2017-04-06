clear all

s=zpk('s');
GG1=(1)/(s*(s+4)*(s+8)); HH1=zpk([],[],1);  % GG - forward transfer function, HH - feedback transfer function

FF=GG1*HH1;   % Open-loop transfer function (without gain K)
FF

% Find zeroes of the closed-loop system
[ZZ_forward,x,y]=zpkdata(GG1);  ZZ_forward=ZZ_forward{1};    % Zeroes of the forward TF
[x,ZZ_feedback,y]=zpkdata(HH1);  ZZ_feedback=ZZ_feedback{1}; % Poles of the feedback TF
ZZ=[ZZ_forward;ZZ_feedback];  % The array of all zeroes of the closed-loop TF

figure(1)
h=rlocusplot(FF); % Plot the root locus, the function returns the plot handle
p=getoptions(h); % Get options for plot.
p.XLim=[-15,3];  % Limits for the X (real) axis
p.YLim=[-5,5];   % Limits for the Y (imaginary) axis
setoptions(h,p); % Apply options to plot.
sgrid(0.456,0:5:10)  % Show grid
sgrid            % Show grid

hold on     % Plot zeroes of the closed loop system
plot(real(ZZ),imag(ZZ),'ro','MarkerSize',12);
hold off
