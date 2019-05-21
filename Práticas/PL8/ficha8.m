clear yn FS
[yn, Fs] = audioread('noisy_voice.wav');
N=size(yn,1);
t=[0:N-1]./Fs;
figure
plot(t,yn)
xlabel('Time(s)')
ylabel('Amplitude')
title('Noisy Signal')

[f,Syn]=my_fft(yn,Fs);

figure
plot(f,abs(Syn))
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('Noisy Signal')
sound(yn,Fs)

fiir_LP = load('lowIIRPL1.mat');
G_iir_LP=fiir_LP.G;
SOS_iir_LP=fiir_LP.SOS;

[b_iir_LP, a_iir_LP]=sos2tf(SOS_iir_LP, G_iir_LP);

yiir_LP=filter(b_iir_LP,a_iir_LP,yn);

figure
plot(t,yiir_LP)
xlabel('Time[s]')
ylabel('Amplitude')
title('After LowPass IIR')


[f,Syiir_LP]=my_fft(yiir_LP,Fs);
figure
plot(f,abs(Syiir_LP))

xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('After LowPass IIR')
sound(yiir_LP, Fs)


%remove noise using BandStop IIR

fiir = load ('testePL_IIRBS2.mat');
G_iir=fiir.G;
SOS_iir = fiir.SOS;

[b_iir, a_iir]=sos2tf(SOS_iir, G_iir);

yiir=filter(b_iir,a_iir,yn);

fiir2=load('testePL_IIRBS3.mat');
G_iir2=fiir2.G;
SOS_iir2=fiir2.SOS;

[b_iir2, a_iir2] = sos2tf(SOS_iir2, G_iir2);
yiir = filter(b_iir2,a_iir2,yiir);

figure
plot(t,yiir)
xlabel('Time[s]')
ylabel('Amplitude')
title('After BandStop IIR')


[f,Syiir]=my_fft(yiir,Fs);
figure
plot(t,abs(Syiir))

xlabel('Frequency(Hz)')%talvez tempo
ylabel('Magnitude')%talvezamplitude
title('After BandStop IIR')
sound(yiir_LP, Fs)


%remove noise using BStop FIR

fir_BS1=load('testePL_BS.mat');
b_fir_BS1=fir_BS1.Num;

yfir_BS1=filter(b_fir_BS1, 1, yn);

fir_BS2=load('testePL_BS2.mat');
b_fir_BS2=fir_BS2.Num;

yfir_BS=filter(b_fir_BS2,1,yfir_BS1);

figure
plot(t,yfir_BS)
xlabel('Time(s)')
ylabel('Amplitude')
title('After BandStop FIR')

[f, Syfir_BS] = my_fft(yfir_BS, Fs);