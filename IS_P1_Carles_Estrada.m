clear all;
close all;
clc;


Ro=10e3;
B=3560;
Vin=5;
To=298;
Rs=10e3*((B-2*To)/(B+2*To));

T=linspace (To-25,To+25,51);
Rt=Ro*exp(B*((1./T)-1/298));
Vout=Vin*Rs./(Rs+Rt);
figure
subplot(1,2,1);
plot(T-273,Vout);
xlabel('Temperature (ºC)');
ylabel('V_{out} (V)');

dVdT=Vin*Rs*B*Ro/(To^2)/((Ro+Rs)^2)

n=Vin*Rs/(Rs+Ro)-dVdT*To
Vout_lin=dVdT.*T+n;

hold on
plot(T-273,Vout_lin,'--');
text(42,dVdT*(40+273)+n,'V_{out\_real}')
text(6,dVdT*(5+273)+n,'V_{out\_lin}=0.0487(T+273)-12.4329')
hold off

error=abs(Vout-Vout_lin);

subplot(1,2,2);
plot(T-273, error,'r--');
xlabel('Temperature (ºC)');
ylabel('|Error| (V)');

conf5=find((error./Vout_lin < 0.05).*T);
min5=conf5(1)
max5=conf5(end)

conf1=find((error./Vout_lin < 0.015).*T);
min1=conf1(1)
max1=conf1(end)

