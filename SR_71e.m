clear all

s=zpk('s');

GG1=(1)/(((s^2)+4*s+10)*(s+10)); HH1=zpk([],[],1); % GG1 - forward TF, HH1 - feedback TF
GG2=((s+0.1)*(s+2.2819))/(s*s*(s+3)*(s+8)); HH2=zpk([],[],1); % GG1 - forward TF, HH1 - feedback TF

K1=42.7;    % The value of gain K
K2=88.1;    % The value of gain K

TT1=feedback(K1*GG1,HH1);
S1=stepinfo(TT1);
rise_time1=S1.RiseTime;
settling_time1=S1.SettlingTime;
overshoot1=S1.Overshoot;
peak_value1=S1.Peak;
peak_time1=S1.PeakTime;

TT2=feedback(K2*GG2,HH2);
S2=stepinfo(TT2);
rise_time2=S2.RiseTime;
settling_time2=S2.SettlingTime;
overshoot2=S2.Overshoot;
peak_value2=S2.Peak;
peak_time2=S2.PeakTime;

% Compute the step response
[YY_STEP1,TIME1]=step(TT1);
[YY_STEP2,TIME2]=step(TT2);
%[YY_STEP,TIME]=step(TT,10);

% Compute the steady-state error
[YY_STEP_10,TIME_10]=step(TT1,TIME1(length(TIME1))*10);
steady_state_error1=1-YY_STEP_10(length(YY_STEP_10));
[YY_STEP_10,TIME_10]=step(TT2,TIME2(length(TIME2))*10);
steady_state_error2=1-YY_STEP_10(length(YY_STEP_10));

fprintf('======================  System 1 =========================\n');
fprintf('Steady state error: %e\n',steady_state_error1);
fprintf('Percent overshoot: %.3f\n',overshoot1);
fprintf('Settling time: %.3f\n',settling_time1);
fprintf('Rise time: %.3f\n',rise_time1);
fprintf('Peak time: %.3f\n',peak_time1)
fprintf('Peak value: %.3f\n',peak_value1);
fprintf('======================  System 2 =========================\n');
fprintf('Steady state error: %e\n',steady_state_error2);
fprintf('Percent overshoot: %.3f\n',overshoot2);
fprintf('Settling time: %.3f\n',settling_time2);
fprintf('Rise time: %.3f\n',rise_time2);
fprintf('Peak time: %.3f\n',peak_time2)
fprintf('Peak value: %.3f\n',peak_value2);

sn1=sprintf('SYSTEM 1\n');
s_sse1=sprintf('Steady state error: %e\n',steady_state_error1);
s_op1=sprintf('Percent overshoot: %.3f\n',overshoot1);
s_st1=sprintf('Settling time: %.3f\n',settling_time1);
s_rt1=sprintf('Rise time: %.3f\n',rise_time1);
s_pt1=sprintf('Peak time: %.3f\n',peak_time1);
s_pv1=sprintf('Peak value: %.3f\n',peak_value1);
sn2=sprintf('SYSTEM 2\n');
s_sse2=sprintf('Steady state error: %e\n',steady_state_error2);
s_op2=sprintf('Percent overshoot: %.3f\n',overshoot2);
s_st2=sprintf('Settling time: %.3f\n',settling_time2);
s_rt2=sprintf('Rise time: %.3f\n',rise_time2);
s_pt2=sprintf('Peak time: %.3f\n',peak_time2);
s_pv2=sprintf('Peak value: %.3f\n',peak_value2);


figure(4)
plot(TIME1,YY_STEP1,'b-','LineWidth',2);
hold on
plot(TIME2,YY_STEP2,'r-','LineWidth',2);
hold off
x_min=0; x_max=max([TIME1(length(TIME1)),TIME2(length(TIME2))])*1.02;
y_min=0; y_max=max([max(YY_STEP1),max(YY_STEP2)])*1.02;
axis([x_min,x_max,y_min,y_max]);
xlabel('Time, s');
ylabel('Step response');

text(x_max/20,y_max/4,[sn1,s_sse1,s_op1,s_st1,s_rt1,s_pt1,s_pv1]);
text(x_max/20*11,y_max/4,[sn2,s_sse2,s_op2,s_st2,s_rt2,s_pt2,s_pv2]);

grid on

