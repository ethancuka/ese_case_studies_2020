function road = generateTerrain(T, dt, v, bumpiness, pothole_depth, pothole_width)
%Generate terrain
potholeSamp = round(pothole_width/(100*v*dt));
potholes = conv((rand(T/dt,1)>.99),ones(potholeSamp,1),"same")*(-pothole_depth/100);
road = rand(T/dt,1)*(bumpiness/100)+potholes;
end