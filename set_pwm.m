function action = set_pwm(device, pwm_value)
%% Sets the PWM of the fan
% Inputs:
%  ~ device: serialport object controlling the real world system
%  ~ pwm_value: A value from 0 to 4095 to set the pulse width modulation of
%  the actuator
% Outputs:
%  ~ action: the control action to change the PWM
%
% Created by:  Kyle Naddeo 1/3/2022
% Modified by: Gabe Donados

%% Force PWM value to be valid
if pwm_value > 4095
    pwm_value = 4095;
elseif pwm_value < 0
    pwm_value = 0;
end

%% Send Command
 action = strcat("P", num2str(pwm_value,'%04.f'))% string value of pwm_value, PXXXX
 write(device, action, "string"); %Write to serial port, formatted as 'string'
end
