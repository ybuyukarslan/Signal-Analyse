% Lecture: Condition Monitoring
% Project: Damage detection on bearings
% Name: Yasin Büyükarslan
% Matrikelnummer: 1626421
% Datum: 26.03.2025



close all;

%% The Data

n_wk = 13;     % number of rolling elements
D_w = 3.7;     % Diameter of rolling elements [mm]
D_t = 26.15;   % Part-circle diameter [mm]
alpha = 0;      % Operating contact angle

% Quantity of Bearing Wear Frequencies

ftf = (1/2)*(1-(D_w/D_t)*cos(alpha)); % Fundamental Train Frequency

bsf = (1/2)*(D_t/D_w)*(1-((D_w/D_t)*cos(alpha))^2); % Ball Spin Frequency

bpfo = (1/2)*n_wk*(1-(D_w/D_t)*cos(alpha)); % Ball Pass Frequency Outer Race

bpfi = (1/2)*n_wk*(1+(D_w/D_t)*cos(alpha)); % Ball Pass Frequency Inner Race




%% 1st Signal %%

% Load the data

Signal1 = load('file_019_23192324.mat');

fs1 = Signal1.fs; % Sampling Rate
fn1 = Signal1.fn; % Rotational Frequency
ds1 = Signal1.datensatz; % Input

% Actual Bearing Wear Frequencies for Signal 1

n_ftf1 = fn1*ftf;
n_bsf1 = fn1*bsf;
n_bpfo1 = fn1*bpfo;
n_bpfi1 = fn1*bpfi;

%% Time Domain

n1 = length(ds1); % Length of Signal 1
dt1 = 1/fs1; % Sampling Interval
t1 = 0:dt1:((n1/fs1)-dt1); % Vectors must be the same length!(-dt)
% Total time is the block size divided by sample frequency.

figure(1);
sgtitle('Figure 1: Signal 1 | file019-23192324','Color','b','FontSize',12);
subplot(3,2,1);
plot(t1,ds1);
title('1st Signal Time Domain');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
grid on;
subplot(3,2,2);
plot(t1,ds1);
xlim([1 1.2]);
title('Time Zoomed');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
grid on;

%% Frequenz Domain

fft1 = fft(ds1);
df1 = fs1/n1; % Frequency Resolution
f_achs1 = 0:df1:fs1-df1;

subplot(3,2,3);
plot(f_achs1,abs(fft1)*2/n1); % plot(f_achs1,sqrt(conj(Y1).*Y1)*df1/(fs1/2))
xlim([0 (fs1)/2]);
title('1st Signal Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
grid on;
subplot(3,2,4);
plot(f_achs1,abs(fft1)*2/n1);
xlim([1000 2000]);
title('Frequency Zoomed');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
text(1682.47,4,'\leftarrow Max at 1682 Hz');
grid on;

%Pwelch with default settings but, with frequency on x axis

subplot(3,2,5);
[pxx1,fspec1] = pwelch(ds1,[],[],[],fs1);
plot(fspec1,pxx1);
title('1st Signal PSD with frequencies [Hz]');
xlabel('Frequency [Hz]');
ylabel('PSD (dB/Hz)');
grid on;
subplot(3,2,6)
[pxx1,fspec1] = pwelch(ds1,[],[],[],fs1);
stem(fspec1,pxx1);
xlim([1500 1700]);
title('PSD Zoomed');
xlabel('Frequency [Hz]');
ylabel('PSD (dB/Hz)');
grid on;

%% Envelope

figure(2);
sgtitle('Figure 2: Signal 1 | file-019-23192324.mat','Color','b','FontSize',12);
subplot(2,1,1);
[env_ds1, y1lower] = envelope(ds1); % h1=hcurve_fun(ds1,1,n1);
plot(t1,env_ds1);
title('Time Domain Envelope Zoomed');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
xlim([1 1.5]);
grid on;


% Pwelch_env

subplot(2,1,2);
[pxx1,fspec1] = pwelch(env_ds1,[],[],[],fs1);
stem(fspec1,pxx1,'LineWidth',1)
xlim([1 600]);
title('Envelope Frequency Spectrum Zoomed');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
grid on;

xline(n_ftf1,'LineStyle','-','Color','#D95319','LineWidth',1)
xline(n_bsf1,'-c','LineWidth',1)
xline(n_bpfo1,'-g','LineWidth',1)
xline(n_bpfi1,'-y','LineWidth',1)

xline(fn1,'-r','LineWidth',1);
xline(fn1*2,'-r','LineWidth',1);
legend('Envelope spectrum','FTF','BSF','BPFO','BPFI','Speed','');



%% 2nd Signal %%

% Load the data

Signal2 = load('file_011_23192324.mat');

fs2 = Signal2.fs; % Sampling Rate
fn2 = Signal2.fn; % Rotational Frequency
ds2 = Signal2.datensatz; % Input

% Actual Bearing Wear Frequencies for Signal 2

n_ftf2 = fn2*ftf;
n_bsf2 = fn2*bsf;
n_bpfo2 = fn2*bpfo;
n_bpfi2 = fn2*bpfi;

%% Time Domain

n2 = length(ds2); % Length of Signal 2
dt2 = 1/fs2; % Sampling Interval
t2 = 0:dt2:(n2/fs2)-dt2; % Vectors must be the same length!(-dt)
% Total time is the block size divided by sample frequency.

figure(3);
sgtitle('Figure 3: Signal 2 | file-011-23192324.mat','Color','b','FontSize',12);
subplot(3,2,1);
plot(t2,ds2);
title('2st Signal Time Domain');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
grid on;
subplot(3,2,2);
plot(t2,ds2);
xlim([1 1.2]);
title('Time Zoomed');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
grid on;

%% Frequenz Domain

fft2 = fft(ds2);
df2 = fs2/n2; % Frequency Resolution
f_achs2 = 0:df2:fs2-df2;

subplot(3,2,3);
plot(f_achs2,abs(fft2)*2/n2); % plot(f_achs1,sqrt(conj(Y1).*Y1)*df1/(fs1/2))
xlim([0 (fs2)/2]);
title('2st Signal Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
grid on;
subplot(3,2,4);
plot(f_achs2,abs(fft2)*2/n2);
xlim([500 2000]);
title('Frequency Zoomed');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
text(1371,0.5,'\leftarrow Max at 1371 Hz');
grid on;

%Pwelch with default settings but, with frequency on x axis

subplot(3,2,5);
[pxx2,fspec2] = pwelch(ds2,[],[],[],fs2);
plot(fspec2,pxx2);
title('2st Signal PSD with frequencies [Hz]');
xlabel('Frequency [Hz]');
ylabel('PSD (dB/Hz)');
grid on;
subplot(3,2,6)
[pxx2,fspec2] = pwelch(ds2,[],[],[],fs2);
stem(fspec2,pxx2);
xlim([500 2000]);
title('PSD Zoomed');
xlabel('Frequency [Hz]');
ylabel('PSD (dB/Hz)');
grid on;

%% Envelope

figure(4);
sgtitle('Figure 4: Signal 2 | file-011-23192324.mat','Color','b','FontSize',12);
subplot(2,1,1);
[env_ds2, y2lower] = envelope(ds2); % h2=hcurve_fun(ds2,1,n2);
plot(t2,env_ds2);
title('Time Domain Envelope Zoomed');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
xlim([1 1.5]);
grid on;


% Pwelch_env

subplot(2,1,2);
[pxx2,fspec2] = pwelch(env_ds2,[],[],[],fs2);
stem(fspec2,pxx2,'LineWidth',1)
xlim([1 600]);
title('Envelope Frequency Spectrum Zoomed');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
grid on;

xline(n_ftf2,'LineStyle','-','Color','#D95319','LineWidth',1)
xline(n_bsf2,'-c','LineWidth',1)
xline(n_bpfo2,'-g','LineWidth',1)
xline(n_bpfi2,'-y','LineWidth',1)

xline(fn2,'-r','LineWidth',1);
xline(fn2*2,'-r','LineWidth',1);
legend('Envelope spectrum','FTF','BSF','BPFO','BPFI','Speed','');

text(fn2,1.3,'\leftarrow 1X Speed')



%% 3st Signal %%

% Load the data

Signal3 = load('file_003_23192324.mat');

fs3 = Signal3.fs; % Sampling Rate
fn3 = Signal3.fn; % Rotational Frequency
ds3 = Signal3.datensatz; % Input

% Actual Bearing Wear Frequencies for Signal 3

n_ftf3 = fn3*ftf;
n_bsf3 = fn3*bsf;
n_bpfo3 = fn3*bpfo;
n_bpfi3 = fn3*bpfi;

%% Time Domain

n3 = length(ds3); % Length of Signal 3
dt3 = 1/fs3; % Sampling Interval
t3 = 0:dt3:(n3/fs3)-dt3; % Vectors must be the same length! (-dt)
% Total time is the block size divided by sample frequency.

figure(5);
sgtitle('Figure 5: Signal 3 | file-003-23192324','Color','b','FontSize',12);
subplot(3,2,1);
plot(t3,ds3);
title('3st Signal Time Domain');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
grid on;
subplot(3,2,2);
plot(t3,ds3);
xlim([1 1.15]);
title('Time Zoomed');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
text(1.11,35,'\downarrow fishlike pattern')
grid on;

%% Frequenz Domain

fft3 = fft(ds3);
df3 = fs3/n3; % Frequency Resolution
f_achs3 = 0:df3:fs3-df3;

subplot(3,2,3);
plot(f_achs3,abs(fft3)*2/n3); % plot(f_achs1,sqrt(conj(Y1).*Y1)*df1/(fs1/2))
xlim([0 (fs3)/2]);
title('3st Signal Frequency Domain');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
grid on;
subplot(3,2,4);
plot(f_achs3,abs(fft3)*2/n3);
xlim([1500 2000]);
title('Frequency Zoomed');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
text(1885,0.12,'\leftarrow Max at 1885 Hz');
grid on;

%Pwelch with default settings but, with frequency on x axis

subplot(3,2,5);
[pxx3,fspec3] = pwelch(ds3,[],[],[],fs3);
plot(fspec3,pxx3);
title('3st Signal PSD with frequencies [Hz]');
xlabel('Frequency [Hz]');
ylabel('PSD (dB/Hz)');
grid on;
subplot(3,2,6)
[pxx3,fspec3] = pwelch(ds3,[],[],[],fs3);
plot(fspec3,pxx3);
xlim([1750 2000]);
title('PSD Zoomed');
xlabel('Frequency [Hz]');
ylabel('PSD (dB/Hz)');
grid on;

%% Envelope

figure(6);
sgtitle('Figure 6: Signal 3 | file-003-23192324.mat','Color','b','FontSize',12);
subplot(2,1,1);
[env_ds3, y3lower] = envelope(ds3); % h3=hcurve_fun(ds3,1,n3);
plot(t3,env_ds3);
title('Time Domain Envelope Zoomed');
xlabel('Time [sec]');
ylabel('Amplitude [m/sec^2]');
xlim([1 1.10]);
grid on;


% Pwelch_env

subplot(2,1,2);
[pxx3,fspec3] = pwelch(env_ds3,[],[],[],fs3);
stem(fspec3,pxx3,'LineWidth',1)
ylim([0 0.05])
xlim([0 1600]);
title('Envelope Frequency Spectrum Zoomed');
xlabel('Frequency [Hz]');
ylabel('Amplitude [(m/sec^2)^2]');
grid on;

xline(n_ftf3,'LineStyle','-','Color','#D95319','LineWidth',1)
xline(n_bsf3,'-c','LineWidth',1)
xline(n_bpfo3,'-g','LineWidth',1)
xline(n_bpfi3,'-y','LineWidth',1)


xline(fn3,'-r','LineWidth',1);
xline(fn3*2,'-r','LineWidth',1);
legend('Envelope spectrum','FTF','BSF','BPFO','BPFI','Speed','');




%% FFT_env

%figure(7);
%subplot(2,1,2);
%env_fft3= fft(env_ds3);
%stem(f_achs3,abs(env_fft3)*2/n3,'k','LineWidth',1)
%xlim([1 400]);

%% Periodogram_env

%figure(8);
%subplot(2,1,2);
%[env_spec3, env_fd3] = periodogram(env_ds3, hann(length(env_ds3)), 2^17, fs3);
%stem(env_fd3,env_spec3,'k','LineWidth',1);
%xlim([1 400]);

%%Statistik

Mittelwert1=mean(ds1);
Mittelwert2=mean(ds2);
Mittelwert3=mean(ds3);

Standardabweichung1=std(ds1);
Standardabweichung2=std(ds2);
Standardabweichung3=std(ds3);

Skewness1=skewness(ds1);
Skewness2=skewness(ds2);
Skewness3=skewness(ds3);

Kurt1=kurtosis(ds1)-3;
Kurt2=kurtosis(ds2)-3;
Kurt3=kurtosis(ds3)-3;

Var1=var(ds1);
Var2=var(ds2);
Var3=var(ds3);

RMS1=rms(ds1);
RMS2=rms(ds2);
RMS3=rms(ds3);

Crest1=peak2rms(ds1);
Crest2=peak2rms(ds2);
Crest3=peak2rms(ds3);



[r,lags] = xcorr(ds2(1,1:1200000),ds3(1,1:1200000),100,"unbiased");
figure
subplot(3,1,1)
plot(ds1)
title('Signal1')
xlabel("Abtastpunkt")
ylabel("Beschleunigungswert [m/s^2]")
axis([0 1500000 -50 50])
subplot(3,1,2)
plot(ds2)
title('Signal2')
xlabel("Abtastpunkt")
ylabel("Beschleunigungswert [m/s^2]")
axis([0 1600000 -50 50])
subplot(3,1,3)
plot(ds3)
title('Signal3')
xlabel("Abtastpunkt")
ylabel("Beschleunigungswert [m/s^2]")
axis([0 1200000 -50 50])

figure
subplot(5,1,1)
bar([Mittelwert1,Mittelwert2,Mittelwert3])
title('Mittelwert')
xlabel("Signale")
ylabel("Beschleunigungswert [m/s^2]")
subplot(5,1,2)
bar([Var1,Var2,Var3])
title('Varianz')
xlabel("Signale")
ylabel("Varianz [m/s^2]^2")
subplot(5,1,3)
bar([Skewness1,Skewness2,Skewness3])
title('Skewness')
xlabel("Signale")
ylabel("Schiefe")
subplot(5,1,4)
bar([Kurt1,Kurt2,Kurt3])
title('Kurtosis')
xlabel("Signale")
ylabel("Kurtosis ")
subplot(5,1,5)
bar([RMS1,RMS2,RMS3])
title('RMS')
xlabel("Signale")
ylabel("RMS [m/s^2]")