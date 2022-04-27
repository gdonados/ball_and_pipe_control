function [distance,pwm,target,deadpan] = read_data(device)
%% Reads data sent back from Ball and Pipe system
% Inputs:
%  ~ device: serialport object controlling the real world system
% Outputs:
%  ~ distance: the IR reading from the time of flight sensor
%  ~ pwm: the PWM from the manual knob of the system (NOT THE SAME AS THE
%  PWM YOU MAY SET THROUGH SERIAL COMMUNICATION)
%  ~ target: the desired height of the ball set by the manual knob of the
%  system
%  ~ deadpan: the time delay after an action set by the manual knob of the
%  system
%
% Created by:  Kyle Naddeo 1/3/2022
% Modified by: Gabriel Donados

%% Ask nicely for data
% Write the read character to the BNP system
write(device, "S", "string");

%% Read data
% Read in the serial data
dataIn = read(device, 20, "string");

%% Translate
% Extract received data into correct variables
% Bounds described in BNP user guide
 distance   = str2double(extractBetween(dataIn, 2, 5));
 pwm = str2double(extractBetween(dataIn, 7, 10));
 target     = str2double(extractBetween(dataIn, 12, 15));
 deadpan    = str2double(extractBetween(dataIn, 17, 20));

end
