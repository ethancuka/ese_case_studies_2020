function animateCar(y, r, v, dt, T)
for t = round(10/(v*dt)):round(.05/dt):round(T/dt)
    drawFrame(y, r, t, v, dt)
    drawnow
end
end