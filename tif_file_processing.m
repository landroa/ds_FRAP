%% Read in the csv FIJI data for fluorescence
% 
% fiji_data = readtable('426_spine1_trial2.csv');
% 
% time_pixel = fiji_data(:,1);
% time_pixel = table2array(time_pixel);
% fluor_intensity = fiji_data(:,2);


 % linescan = spineScan();

%% Plotting raw fluorescence

fluor_intensity = linescan(:,6);  

x = length(fluor_intensity);

time_ms = linspace(0,2000,x);

figure
plot(fluor_intensity);

figure
plot(time_ms,fluor_intensity);
xlabel('Time (ms)')
ylabel('Raw fluorescence')
title('Fluorescence intensity for spine 1 ROI over time')
box off 

%% use on PC
% saveas(gcf,'\\nas01.itap.purdue.edu\puhome\My Documents\FRAP\4-26\spine4_trials\Associated curves\sample_fluor_trace8.svg')

%% use on Mac
 saveas(gcf,'/Users/lroa/Desktop/Purdue NNT/FRAP/Data/5-10/spine1_trials/Associated curves/sample_fluor_trace13.svg')
%% Truncate the signal to fit the curve 

len = length(fluor_intensity);
fluor_intensity = fluor_intensity(383:len,:);
time_ms = time_ms(:,383:len);

%% Apply Savitzky-Golay Smoothing Filter
order = 2; 
framelen = 61;
b = sgolay(order,framelen);

steadystate = conv(fluor_intensity,b((framelen+1)/2,:),'valid');

trans_begin = b(end:-1:(framelen+3)/2,:)*fluor_intensity(framelen:-1:1);

trans_end = b((framelen-1)/2:-1:1,:)*fluor_intensity(end:-1:end-(framelen-1));

sgolay_fluor_trans = [trans_begin; steadystate; trans_end];


figure

plot(time_ms,sgolay_fluor_trans);

title('Filtered fluorescence trace')
xlabel('Time/ms')
ylabel('Fluorescence intensity')
box off

%% use on PC
% saveas(gcf,'\\nas01.itap.purdue.edu\puhome\My Documents\FRAP\4-26\spine4_trials\Associated curves\filt_trace8.svg')

%% use on Mac
 saveas(gcf,'/Users/lroa/Desktop/Purdue NNT/FRAP/Data/5-10/spine1_trials/Associated curves/filt_trace13.svg')


[fitresult, gof] = createFit(sgolay_fluor_trans);

coeffvals = coeffvalues(fitresult);
teq = coeffvals(2);

figure
plot(sgolay_fluor_trans)
hold on
plot(fitresult)
box off
xlim([-100 5000])
ylim([0 200])
title('Fitted FRAP curve for Spine 1, trial 13')
ylabel('Average Fluorescence Intensity')

%% use when on PC
% saveas(gcf,'\\nas01.itap.purdue.edu\puhome\My Documents\FRAP\4-26\spine4_trials\Associated curves\spine4_trial8_curve.svg')
% save('\\nas01.itap.purdue.edu\puhome\My Documents\FRAP\4-26\spine4_trials\Associated teq\spine4_trial8_teq.mat','teq')


%% use when on Mac
 saveas(gcf,'/Users/lroa/Desktop/Purdue NNT/FRAP/Data/5-10/spine1_trials/Associated curves/spine1_trial13_curve.svg')
 save('/Users/lroa/Desktop/Purdue NNT/FRAP/Data/5-10/spine1_trials/Associated teq/spine1_trial13_teq.mat','teq')

%% T_eq stats 

t_eq_spine1 = [teq_1 teq_2 teq_3 teq_4 teq_5 teq_6 teq_7 teq_8 teq_9 teq_10 teq_11 teq_12 teq_13];
trial_num = [1 2 3 4 5 6 7 8 9 10 11 12 13];

figure
scatter(trial_num, t_eq_spine1);
title('T_eq for Spine 1 across 13 trials')
ylabel('T_eq (ms)')
xlabel('Trial number')
box off
grid on
xlim([0 14])
ylim([20 100])

%% use on PC
%saveas(gcf, '\\nas01.itap.purdue.edu\puhome\My Documents\FRAP\4-26\spine4_trials\t_eq_for_all_trials.svg')

%% use on Mac
saveas(gcf,'/Users/lroa/Desktop/Purdue NNT/FRAP/Data/5-10/spine1_trials/t_eq_for_all_trials.svg')


figure
boxplot(t_eq_spine1)
xlabel('Spine 1')
ylabel('T_eq (ms)')
title('Boxplot for spine 1 t_eq')

%% use on PC
%saveas(gcf,'\\nas01.itap.purdue.edu\puhome\My Documents\FRAP\4-26\spine4_trials\boxplot_spine4_teq.svg')

%% use on Mac
saveas(gcf,'/Users/lroa/Desktop/Purdue NNT/FRAP/Data/5-10/spine1_trials/boxplot_spine1_teq.svg')
