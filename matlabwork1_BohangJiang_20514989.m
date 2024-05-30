
%Bohang Jiang
%ssybj2@nottingham.edu.cn

%preliminary task
5a=arduino('COM3','UNO');
for i= 1:10
    writeDigitalPin(a,'D2',1);
    pause(0.5);
    writeDigitalPin(a,'D2',0);
    pause
end

%Task1
a=arduino('COM3','UNO')
duration = 600;
x=1:duration;
inrerval = 1;
numSamples= duration/inrerval; 
vaoltage_values = zeros(1,duration);
tempreature_values = zeros(1,duration);
Tc=0.01;
VOC=0.5;
for t = 1:duration;
voltage = readVoltage(a,"A2");
temperature = (voltage - VOC)/Tc;
tempreature_values(t) = temperature;
pause(1);
end;
min_temperature=min(tempreature_values );
max_temperature=max(tempreature_values);
avg_temperature=mean(tempreature_values);

figure;
plot(1:duration, tempreature_values)
xlabel('Time(seconds)');
ylabel('Temperature(°C)');
title('Temperature vs Time');
grid on
str=[sprintf('\n') 'Data logging initiated-5/3/2024' sprintf('\n') 'Location_Nottingham'];
disp(str);
fprintf('Minimun Temperature: %.2f\n ', min_temperature);
fprintf('Maximum Temperature: %.2f\n', max_temperature);
fprintf('Average Temperature: %.2f\n', avg_temperature);

for i = 1:numSamples
    if mod(i,60) == 0;
        minute = i/60;
        fprintf ('%d\t%.2f\n',minute, sprintf('\n'), temperature_values(i));
    end
end
Location = 'Nottingham';
fileID = fopen('Cabin_temperature.txt','w');
fprintf(fileID,'Data logging initiated - %s\n', datestr(now, 'dd-mmm-yyyy'));
fprintf(fileID, 'Location: Nottingham');
fprintf('Data: %s\nLocation: %s\n\n', datestr(now, 'dd-mmm-yyyy'), Location);
fprintf('Minute\t\tTemperature (°C)\n');

for i = 1:60:x
    minute= i/60;
    fprintf('\n')
    fprintf('Minute %d\n', minute);
    fprintf('Temperature %.2f C\n', temperature(i));
    fprintf('\n\n');
    fprintf(fileID,'\n\n');
    fprintf(fileID,'Minute % d\n', minute);
    fprintf(fileID,'Temperature %.2f C\n', temperature(i));
    fprintf(fileID, '\n\n');
end

fprintf('\n');
fprintf('Max temp %.2f C\n', max_temperature);
fprintf('Min temp %.2f C\n', min_temperature);
fprintf('Average temp %.2f C\n', avg_temperature);
fprintf('Data logginf terminated\n');
fprintf('\n');

fprintf(fileID,'\n');
fprintf(fileID,'Max temp %.2f C\n', max_temperature);
fprintf(fileID,'Min temp %.2f C\n', min_temperature);
fprintf(fileID,'Average temp %.2f C\n', avg_temperature);
fprintf(fileID,'\n');
fprintf(fileID,'Data logging terminated\n');
fprintf(fileID,'\n');

fclose(fileID);

fileID = fopen('Cabin_temperature.txt','r');
fileContent = fread(fileID,'*char')';
fclose(fileID);

disp('Content of Cabin_temperature.txt:');
disp(fileContent);

fopen('Content of Cabin_temperature.txt')