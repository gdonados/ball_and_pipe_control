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
% use the serialport() command options to write the correct letter to the
% system (Hint: the letters are in the spec sheet)
s = serialPort(device,19200);
write(s, "S", "string");

%% Read data
% use the serialport() command options to read the response
dataIn = read(s, 20, "string");

%% Translate
% translate the response to 4 doubles using str2double() and
% extractBetween() (Hint: the response is in the spec sheet)
 dataIn = str2double(dataIn):
 distance   = extractBetween(dataIn, 2, 5);
 manual_pwm = extractBetween(dataIn, 7, 10);
 target     = extractBetween(dataIn, 12, 15);
 deadpan    = extractBetween(dataIn, 17, 20);

end