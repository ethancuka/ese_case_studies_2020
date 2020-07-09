%Devise a state feedback controller that uses sensor readings from the
%vehicle and road to decide how much force to exert on the vehicle body.
%Force is measured in newtons, so you may need to apply a very large force
%to see the system change significantly

% The piston automatically accounts for gravity, so you do not need to
% account for it in your function.

% This piston has the following readings:
% vehiclePosition: The current verticle position of the vehicle body,
%                  measured relative to an equilibrium/starting point.
%                  (meters)
% vehicleVelocity: The current vertical velocity of the vehicle body (m/s)
% vehicleAcceleration: The current vertical acceleration of the vehicle
%                      body. (m/s^2)

function force = piston_controller_sample(vehiclePosition, vehicleVelocity, vehicleAcceleration)
force = -10000*vehicleVelocity;
end