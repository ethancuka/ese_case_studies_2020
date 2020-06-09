function road = generateTerrain(sim_length, road_bumpiness, pothole_depth, pothole_width)
%Generate terrain
potholeSamp = round(pothole_width/(100*v*dt));
potholes = conv((rand(T/dt,1)>.99),ones(potholeSamp,1),"same")*(-pothole_depth/100);
r = rand(T/dt,1)*(bumpiness/100)+potholes;



%TODO: create more robust terrain generation that can create potholes of
%various sizes and widths, as well as ramps and bumps.
end