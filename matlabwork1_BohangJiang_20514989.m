
%Bohang Jiang
%ssybj2@nottingham.edu.cn

%preliminary task
clear
a=arduino('COM3','UNO');
for i=1:10
    writeDigitalPin(a,'D2',1)
    pause(0.5)
    writeDigitalPin(a,'D2',0)
end

%Task1
duration=600;
vaoltage_values = zeros(1,duration);
tempreature_values = zeros(1,duration);
Tc=10;
VOC=0.5;
for t = 1:duration
voltage = rand()*5;
temperature = (voltage - VOC)/Tc;
tempreature_values(t) = temperature;
pause(1)
end
min_temperature=min(tempreature_values);
max_temperature=max(tempreature_values);
avg_temperature=mean(tempreature_values);

fprintf('Minimun Temperature: %.2f\n', min_temperature)
fprintf('Maximum Temperature: %.2f\n', max_temperature)
fprintf('Average Temperature: %.2f]n', avg_temperature)

figure;
plot(1:duration, tempreature_values)
xlabel('Time(seconds)');
ylabel('Temperature(°C)');
title('Temperature vs Time');

str=['Data logging initiated-5/3/2024' sprintf('\n') 'Location_Nottingham'];
disp(str)