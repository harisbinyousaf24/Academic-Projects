clc
clear all
kt = 0.0398;
kb = 0.0398;
Ra = 0.64;
J = 0.0214;
Da = 0.85;

A = kt*Ra*J
B = Da/J
C = (kt*kb)/(Ra*J)
D = B + C

num = [A];
den = [1 D 0];
sys = tf(num, den)
step(sys)