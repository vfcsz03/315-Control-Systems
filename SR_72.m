clear all

s=zpk('s');

GG1=(1)/(s*(s+4)*(s+8)); HH1=zpk([],[],1); % GG1 - forward TF, HH1 - feedback TF

K=83.8;    % The value of gain K

TT=feedback(K*GG1,HH1);
S=stepinfo(TT);
rise_time=S.RiseTime;
settling_time=S.SettlingTime;
overshoot=S.Overshoot;
peak_value=S.Peak;
peak_time=S.PeakTime;

% Compute the step response
[YY_STEP,TIME]=step(TT);
%[YY_STEP,TIME]=step(TT,10);

% Compute the steady-state error
[YY_STEP_10,TIME_10]=step(TT,TIME(length(TIME))*10);
steady_state_error=1-YY_STEP_10(length(YY_STEP_10));

fprintf('Steady state error: %e\n',steady_state_error);
fprintf('Percent overshoot: %.3f\n',overshoot);
fprintf('Settling time: %.3f\n',settling_time);
fprintf('Rise time: %.3f\n',rise_time);
fprintf('Peak time: %.3f\n',peak_time)
fprintf('Peak value: %.3f\n',peak_value);

s_sse=sprintf('Steady state error: %e\n',steady_state_error);
s_op=sprintf('Percent overshoot: %.3f\n',overshoot);
s_st=sprintf('Settling time: %.3f\n',settling_time);
s_rt=sprintf('Rise time: %.3f\n',rise_time);
s_pt=sprintf('Peak time: %.3f\n',peak_time);
s_pv=sprintf('Peak value: %.3f\n',peak_value);

figure(3)
plot(TIME,YY_STEP,'b-','LineWidth',2);
x_min=0; x_max=TIME(length(TIME))*1.02;
y_min=0; y_max=max(YY_STEP)*1.02;
axis([x_min,x_max,y_min,y_max]);
xlabel('Time, s');
ylabel('Step response');
text(x_max/2,y_max/2,[s_sse,s_op,s_st,s_rt,s_pt,s_pv]);
grid on

