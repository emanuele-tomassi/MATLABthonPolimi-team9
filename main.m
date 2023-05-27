%connect to phone and get accel data
clear m
m = mobiledev;
m.AccelerationSensorEnabled = 1;
m.Logging = 1;
%initialize data for rolling plot
datax = zeros(200,1);
datay = zeros(200,1);
dataz = zeros(200,1);
%initialize plot
figure(1)
p = plot(data);
axis([0 200 -15 15]);
pause(1)
tic
d = 0;
while (toc < 3600*2 && m.Logging == 1)%run for 200 secs
      %get new z coordinates
      [a,t] = accellog(m);
      [lat,lon,tpos,~,~,alt,~] = poslog(m);
      figure(2)
      geoplot(lat,lon)
      geobasemap satellite

      if length(a) > 200
        datax = a(end-199:end,1);
        datay = a(end-199:end,2);
        dataz = a(end-199:end,3);
      else
        datax(1:length(a)) = a(:,1);
        datay(1:length(a)) = a(:,2);
        dataz(1:length(a)) = a(:,3);
      end
       %redraw plot
       p.YData = datax;
      %p.YData = datay;
      %p.YData = dataz;
      drawnow
end
t_step=t(end)-t(end-1);
vvv=zeros(length(a),3);
for sium=1:length(a)-1
    vvv(sium,1)=(a(sium,1)+a(sium+1,1))/2*t_step;
    vvv(sium,2)=(a(sium,2)+a(sium+1,2))/2*t_step;
end

zzzzzzzz=sqrt(vvv(:,2).^2+vvv(:,1).^2);

figure(3)
plot(t,zzzzzzzz,t,movmean(zzzzzzzz,100),'LineWidth',3);
legend('Velocità istantanea parallela al pavimento','Velocità istantanea parallela al pavimento più accurata')

for i  = 2:length(lat)
    d = d + (distance(lat(i-1),lon(i-1),lat(i),lon(i))/360)*(2*6371e3*pi);
end

n_passi = d/0.762;


%% find closest pizzeria

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
str = sprintf('Hai percorso %.15g m, per un totale di %.15g passi. La pizzeria più vicino a te è %s, in %s, a una distanza di %.5g m',d, n_passi, nome,indirizzo,C)
uiwait(msgbox(str, 'MAMMA MIA!',"custom",myicon));