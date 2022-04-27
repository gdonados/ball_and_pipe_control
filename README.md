## Intro to Ball and Pipe Project
For this project, there is a vertical pipe system that has a fan at the bottom. A ping pong ball is placed at the bottom and through the use of a controller, the ping pong ball will be shot up to any specific height the user wishes to choose. For this specific project, our group chose the MPC controller. Figure 3 shows the overall diagram. The MPC starts with a reference point, which is the height the user wants the ball to rest at, and the initial height of the ball, the MPC will start updating after every time step. 
After the first update, the output, which is the new height, is fed back into the input of the MPC block. This occurs over and over until the ball is at the desired height, and theoretically, the system will keep constant after this point. A problem that our simulation ran into was once the desired height was reached, the PWM output from the MPC block would go back down to 0, which then turned the fan off. 

## About MPC 
MPC, or Model Predictive Control, is used widely to model self-driving cars and autonomous vehicles that tend to converge at a specific point. This is due to MPC predicting and acting instead of reacting. We decided to use MPC for the Ball and Pipe project to predict what the transfer function will output instead of getting results and checking to see if the data is correct. MPC has an option to make the signal more or less aggressive for the predicted output, so you can manipulate the output to be as close as possible to the desired output. The transfer function needs to be converted to a space state model to output a useable signal for the ball and pipe system. Overall, MPC is usually used for more difficult simulations, and we could not figure out how to get usable results.

## Code Guide
To use the code with the designed MPC controller is simple. The controller takes in a measured output and generates the next input to use, as described before. In this case, the BNP system parameters needed are ball height, meters, and a PWM value. To use with the MPC, the ball height acts as the input to the measured output (MO) of the MPC, which predicts the subsequent best PWM values, which are then input to the BNP system with set_pwm(). 

The MPC block was designed with PWM constraints of 1000 to 4095, and ball height constraints of 0 to 1. The reference signal given to the system was the unit step, for simulation purposes. Additional constraints were added to reduce how large the jumps in PWM could be to coincide with the real-life limitations of the system. The PWM was only allowed to increase/decrease by a value of 100 at a time.

To modify the MPC, the MPC designer tool in MATLAB can be accessed from the Simulink model by double-clicking the MPC block. Here, constraints can be edited and weights can be changed to increase/decrease the aggressiveness of the prediction model.

## Simulation Results

## References
https://www.mathworks.com/products/model-predictive-control.html 
https://www.mathworks.com/products/simcontrol.html 
https://en.wikipedia.org/wiki/Model_predictive_control
https://www.youtube.com/watch?v=YwodGM2eoy4
https://web.stanford.edu/class/archive/ee/ee392m/ee392m.1056/Lecture14_MPC.pdf
https://www.do-mpc.com/en/v4.1.1/theory_mpc.html
