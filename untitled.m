%Bohang Jiang
%ssybj2@nottingham.edu.cn

%preliminary task

a=arduino('COM3','UNO');
for i=1:10
    writeDigitalPin(a,'D2',1)
    pause(0.5)
    writeDigitalPin(a,'D2',0)
end
