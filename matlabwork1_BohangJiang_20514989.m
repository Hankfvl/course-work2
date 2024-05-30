
%Bohang Jiang
%ssybj2@nottingham.edu.cn

%preliminary task
a=arduino('COM3','UNO');
for i= 1:10
    writeDigitalPin(a,'D2',1);
    pause(0.5);
    writeDigitalPin(a,'D2',0);
    pause
end

%Task1
a=arduino('COM3','UNO');
duration = 6;
x=1:duration;
inrerval = 1;
numSamples= duration/inrerval; 
voltage_values = zeros(1,duration);
tempreature_values = zeros(1,duration);
Tc=0.01;
VOC=0.5;
for t = 1:duration
voltage = readVoltage(a,"A2");
temperature = (voltage - VOC)/Tc;
tempreature_values(t) = temperature;
pause(1);
end
min_temperature=min(tempreature_values );
max_temperature=max(tempreature_values);
avg_temperature=mean(tempreature_values);

figure;
plot(1:duration, tempreature_values)
xlabel('Time(seconds)');
ylabel('Temperature(°C)');
title('Temperature vs Time');
grid on
str=[newline 'Data logging initiated-5/3/2024' newline 'Location_Nottingham'];
disp(str);
fprintf('Minimun Temperature: %.2f\n ', min_temperature);
fprintf('Maximum Temperature: %.2f\n', max_temperature);
fprintf('Average Temperature: %.2f\n', avg_temperature);

for i = 1:numSamples
    if mod(i,60) == 0
        minute = i/60;
        fprintf ('%d\t%.2f\n',minute, newline, temperature_values(i));
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


%TASK2
% Create Arduino object
a = arduino('COM4');

% Define LED pins
greenLED = 'D2';
yellowLED = 'D3';
redLED = 'D4';

% Define temperature sensor pin (assumed to be analog pin A0)
tempSensorPin = 'A0';

while true
% Read temperature sensor value
sensorValue = readVoltage(a, tempSensorPin);
temperature = sensorValue * 100; % LM35 conversion formula: 1V = 100°C

% Print temperature value to the console (for debugging)
fprintf('Temperature: %.2f\n', temperature);

% Control LEDs based on temperature value
if temperature >= 18 && temperature <= 24
writeDigitalPin(a, greenLED, 1); % Turn on green LED
writeDigitalPin(a, yellowLED, 0); % Turn off yellow LED
writeDigitalPin(a, redLED, 0); % Turn off red LED
elseif temperature < 18
writeDigitalPin(a, greenLED, 0); % Turn off green LED
writeDigitalPin(a, redLED, 0); % Turn off red LED
blinkLED(a, yellowLED, 0.5); % Blink yellow LED at 0.5s intervals
elseif temperature > 24
writeDigitalPin(a, greenLED, 0); % Turn off green LED
writeDigitalPin(a, yellowLED, 0); % Turn off yellow LED
blinkLED(a, redLED, 0.25); % Blink red LED at 0.25s intervals
end

% Delay 1 second to ensure correct timing for data acquisition
pause(1);
end


%TASK3
clear
a=arduino('COM3','UNO');
c=cell()

for i=1:30
    V=readVoltage(a,A1)
    T=(V-0.5)*100
   
    c{i}=T
    b=c{i}-c{i-1}
    if -0.067<b<0.067  && b==0.067 &&  b==-0.067 
        writeDigitalPin(a, 'A1', 1)
        writeDigitalPin(a, 'A2', 0)
        writeDigitalPin(a, 'A3', 0)
    elseif b>0.067
        writeDigitalPin(a, 'A1', 0)
        writeDigitalPin(a, 'A2', 1)
        writeDigitalPin(a, 'A3', 0)
    elseif b<-0.067
        writeDigitalPin(a, 'A3', 1)
        writeDigitalPin(a, 'A2', 0)
        writeDigitalPin(a, 'A1', 0)
    end


    disp([' The change rate is' ,b, ' °C']);
    disp([' The temperature is' ,T, ' °C'])
    pause(1)
end
T=T+300*(c{30}-c{1})/30
disp('The temperature will be ',T,'°C in 5 min')


%TASK4
%During the development of the LED temperature monitoring device and the associated MATLAB scripts, I encountered several challenges and learned significantly.

%One primary challenge was establishing reliable communication between MATLAB and Arduino. Configuring the hardware support package and ensuring the correct COM port required meticulous attention to detail. Additionally, integrating the temperature sensor and ensuring accurate readings posed difficulties due to noise and data fluctuations. Implementing a stabilization resistor helped mitigate some of these issues.

%Another significant challenge was developing the real-time LED control logic. Ensuring that the LEDs blinked at the correct intervals and responded appropriately to temperature changes required precise timing controls within the MATLAB script. Balancing the updating of the live temperature plot with managing the LED states was tricky, as both processes needed to be handled concurrently without causing significant delays.

%A key strength of the project was the successful integration of MATLAB's plotting capabilities with real-time data acquisition from Arduino. This provided a visual representation of temperature changes, aiding in debugging and verifying the functionality of the LED controls. Using flowcharts before coding also proved beneficial, allowing for a clear implementation plan and a smoother coding process.

%However, the current implementation has limitations. The noise in temperature readings, even with stabilization efforts, indicates that further filtering techniques could improve accuracy. The LED control logic might not effectively account for rapid temperature fluctuations. More sophisticated algorithms could provide a more robust response.

%Overall, this project provided valuable hands-on experience with MATLAB, Arduino, and real-time data processing. The challenges faced and overcome have deepened my understanding of embedded systems and their applications in monitoring and control tasks.
