%Devise a state feedback controller that uses sensor readings from the
%vehicle and road to decide how much force to exert on it. Remember that
%the piston has a minimum length of 5 cm and a maximum length of 17 cm. You
%do not need to use all the arguments if you don't want to.

% The piston automatically accounts for gravity, so you do not need to
% account for it in your function.

% This piston has the following readings:
% pistonLength: The current length of the piston in cm
% vehicleVelocity: The current vertical velocity of the vehicle body
% vehicleAcceleration: The current vertical acceleration of the vehicle
% body.

function force = piston_controller(pistonLength, vehicleVelocity, vehicleAcceleration)
%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%
force = 0;
end