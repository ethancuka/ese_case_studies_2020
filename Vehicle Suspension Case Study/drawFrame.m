% A helper function for the case study. When called, it plots a single
% frame of the vehicle simulation

function drawFrame(y, r, t, v, dt)
    %Clear current frame
    clf
    
    %Compute positions of frame objects
    backwheelY = r(max(round(t-5/(v*dt)),1))+.25;
    backbodyY = .75+y(max(round(t-5/(v*dt)),1));
    frontwheelY = r(t)+.25;
    frontbodyY = .75+y(t);
    
%     backwheelY = r(max(round(t-5/(v*dt)),1))+.25;
%     backbodyY = r(max(round(t-5/(v*dt)),1))+.75+y(max(round(t-5/(v*dt)),1));
%     frontwheelY = r(t)+.25;
%     frontbodyY = r(t)+.75+y(t);
    
    roadHeight = r(max(round(t-10/(v*dt)),1): min(round(t+5/(v*dt)),length(r)));
    roadFrame = linspace(0,15,15/(v*dt));
    
    %Trim sim boundaries to mitigate roundoff errors
    if length(roadHeight)>round(15/(v*dt))
        roadHeight = roadHeight(1:round(15/(v*dt)));
    end
    
    hold on;
    %Draw road
    plot(roadFrame(1:length(roadHeight)), roadHeight);
    %Draw wheels
    circle(5,backwheelY,.25);
    circle(10,frontwheelY,.25);
    %Draw frame
    line([5,5], [backwheelY, backbodyY]);
    line([5,10], [backbodyY, frontbodyY]);
    line([10,10], [frontwheelY, frontbodyY]);

    %Plot constraints
    xlim([0 15]);
    ylim([-1 2]);
    title("Vehicle Simulation")

end