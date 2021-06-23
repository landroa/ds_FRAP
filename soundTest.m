clear

freq = 4000;
time = 3;
sampling = 200000;

soundMatrix = 2*sin(2*pi*freq*((0:sampling*time)/sampling));
timeMatrix = (0:sampling*time)/sampling;

freq2 = 4000;
time2 = 3;
sampling2 = 200000;

soundMatrix2 = 2*sin(2*pi*freq2*((0:sampling2*time2)/sampling2));
timeMatrix2 = (0:sampling2*time2)/sampling2;

freq3 = 4000;
time3 = 3;
sampling3 = 200000;

soundMatrix3 = 2*sin(2*pi*freq3*((0:sampling3*time3)/sampling3));
timeMatrix3 = (0:sampling3*time3)/sampling3;


sound(soundMatrix, sampling);

