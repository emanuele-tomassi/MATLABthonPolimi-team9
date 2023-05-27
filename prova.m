%connect to phone and get accel data
clear m
m = mobiledev;
m.AccelerationSensorEnabled = 1;
m.Logging = 1;
%initialize data for rolling plot
data = zeros(200,1);
%initialize plot
figure(1)
p = plot(data);
axis([0 200 -15 15]);
pause(1)
tic
d = 0;
checklength = 2;
dist = [];
while (toc < 200)%run for 30 secs
      %get new z coordinates
      [a,t] = accellog(m);
      [lat,lon,tpos,~,~,alt,~] = poslog(m);
      if length(a) > 200
        data = a(end-199:end,3);
      else
        data(1:length(a)) = a(:,3);
      end
      if (length(tpos) == checklength)
          d_loc = (distance(lat(end-1),lon(end-1),lat(end),lon(end))/360)*(2*6371e3*pi);
          d = d + d_loc;
          dist = [dist;d_loc]
          checklength = checklength + 1; 
          figure(2)
          plot(lat,lon,'k');
          hold on
          plot(lat(end),lon(end),'or');
          hold off

      end
      % redraw plot
      %p.YData = data;
      %drawnow
end
%%

load('pizzeria_address.mat');
load('pizzeria_coord.mat');
load('pizzeria_name.mat');

dist_to_pizz = zeros(1, length(pizzeria_coord));

for var = 1:length(pizzeria_coord)
    
    d_pizz = (distance(pizzeria_coord(var,1),pizzeria_coord(var,2),lat(end),lon(end))/360)*(2*6371e3*pi);

    dist_to_pizz(var) = d_pizz;
    
end

[mindist, idx] = min(dist_to_pizz);

closest_pizzeria = pizzeria_name(idx);
closest_pizzeria_address = pizzeria_address(idx);
closest_pizzeria_distance = dist_to_pizz(idx);

myicon = imread("6978255.jpeg");
nome = closest_pizzeria;
indirizzo = closest_pizzeria_address;
C = closest_pizzeria_distance;
str = sprintf('La pizzeria più vicino a te è %s, in %s, a una distanza di %.5g m',nome,indirizzo,C)
uiwait(msgbox(str, 'MAMMA MIA!',"custom",myicon));

