% A MATLAB script to control Rowans Systems & Control Floating Ball 
% Apparatus designed by Mario Leone, Karl Dyer and Michelle Frolio. 
% Designed to use a MPC controller
%
% Created by Kyle Naddeo, Mon Jan 3 11:19:49 EST 
% Modified by Gabe Donados

%% Start fresh
close all; clc; clear device;

%% Connect to device
 device = serialport("COM7", 19200);%open serial communication in the proper COM port

%% Parameters
target      = 0.5;   % Desired height of the ball [m]
sample_rate = 0.25;  % Amount of time between controll actions [s]
%% Create MPC Object for Designer
g = zpk([],[0 -7.8067], 0.03887); %Transfer function
gss = ss(g);    %Convert to state space

Ts = 0.1; %Sample time
MV = struct('Min', 0, 'Max', 100); %duty cycle
OV = struct('Min', 0, 'Max', 0.98); %Ball Height

p = 20; %Prediction Horizon
m = 3;  %Control Horizpn

mpcobj = mpc(gss, Ts, p, m, [], MV); %Create MPC object to design

%% Feedback loop
while true
    %% Read current height, send height to MPC model
    [distance,pwm,target,deadpan] = read_data(device);
    ball_height = ir2y(distance); % Convert from IR reading to distance from bottom [m]
    
    %% Set PWM based on MPC output
    set_pwm(duty_cycle);
    
    % Wait for next sample
    pause(sample_rate)
end

