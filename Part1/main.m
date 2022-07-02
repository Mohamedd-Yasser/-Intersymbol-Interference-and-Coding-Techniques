close all
channel_bandwidth = 100000;

% Sampling frequency for plotting (for now this value is random)
fs = 100 * channel_bandwidth;

% Pulse properties: duration and amplitude
pulse_len = 2 / channel_bandwidth;
bit_amplitude = 1;

% Basic pulse unit and its time vector
t_bit = linspace(0, pulse_len, pulse_len * fs);
bit_waveform = ones(1, length(t_bit)) * bit_amplitude;

% Signal for each bit and their time vector
t2 = linspace(0, 2 * pulse_len, 2 * pulse_len * fs);
bit1 = [bit_waveform zeros(1, length(t_bit))];
bit2 = [zeros(1, length(t_bit)) bit_waveform];

% Frequency vector
f = linspace(-fs/2, fs/2, length(bit1));

% FFT of both bits
bit1_spectrum = fftshift(fft(bit1));
bit2_spectrum = fftshift(fft(bit2));

% The channel filter that models passing a signal through the channel
channel_filter = ones(size(f));
channel_filter(find(f < -channel_bandwidth | f > channel_bandwidth)) = 0;

% Passing each bit individually through the channnel
bit1_filtered = real(ifft(ifftshift(channel_filter .* bit1_spectrum)));
bit2_filtered = real(ifft(ifftshift(channel_filter .* bit2_spectrum)));

% Plots

plotpulse(bit1, fs, 'One Bit', 3000, 2*pulse_len);
plotpulse(bit1_filtered, fs, 'One Bit Passed Through The Channel', 3000, 2*pulse_len);

figure;

subplot(2, 1, 1);
plot(t2, bit1);
hold on;
plot(t2, bit2);
title('Two Consecutive Bits');

subplot(2, 1, 2);
plot(t2, bit1_filtered);
hold on;
plot(t2, bit2_filtered);
title('Two Consecutive Bits Passed Through The Channel');

% ====== Part 1.2 ====== %

% Waveform for Zero ISI (theoretically)
% Sending out a sinc pulse that satisfies Nyquist's criterion

% Basic pulse unit and it's time vector
% Extended time vector for better visualization
t3 = linspace(0, 4 * pulse_len, 4 * pulse_len * fs);

pulse1 = sinc((t3-(pulse_len))/(pulse_len));
pulse2 = sinc((t3-(2*pulse_len))/(pulse_len));

% Signal for each bit and their time vector

% Frequency vector
f = linspace(-fs/2, fs/2, length(pulse1));

% FFT of both bits
pulse1_spectrum = fftshift(fft(pulse1));
pulse2_spectrum = fftshift(fft(pulse2));

% The channel filter that models passing a signal through the channel
channel_filter = ones(size(f));
channel_filter(find(f < -channel_bandwidth | f > channel_bandwidth)) = 0;

pulse1_filtered = real(ifft(ifftshift(channel_filter .* pulse1_spectrum)));
pulse2_filtered = real(ifft(ifftshift(channel_filter .* pulse2_spectrum)));

% Plots

plotpulse(pulse1, fs, 'One sinc Pulse', 250, 4*pulse_len);
plotpulse(pulse1_filtered, fs, 'One sinc Pulse Passed Through The Channel', 250, 4*pulse_len);

% figure;
% 
% subplot(2, 1, 1);
% plot(t3, pulse1);
% hold on;
% plot(t3, pulse2);
% title('Two Consecutive sinc Pulses in Time');
% 
% subplot(2, 1, 2);
% plot(t3, pulse1_filtered);
% hold on;
% plot(t3, pulse2_filtered);
% title('Two Consecutive Sinc Pulses Passed Through The Channel');

% ======== Raised Cosine Pulse Shaping Approach ======== %

raised_cosine = zeros(size(f));
beta = 1;

for i = 1:length(f)
    if abs(f(i)) <= ((1-beta)/(2*pulse_len))
        raised_cosine(i)=1;
    elseif abs(f(i))<=(1+beta)/(2*pulse_len) && abs(f(i))>((1-beta)/(2*(pulse_len)))
        raised_cosine(i)=0.5*(1 + cos(((pi*pulse_len)/beta) * (abs(f(i)) - ((1-beta)/(2*pulse_len)) ) ) );
    else 
        raised_cosine(i)=0;
    end
end

time_shift = exp(-2*pi*j*pulse_len*f);

nyquist_bit1 = real(ifft(ifftshift(raised_cosine)));
nyquist_bit2 = real(ifft(ifftshift(raised_cosine .* time_shift)));

% Normalize both amplitudes to the desired amplitude
nyquist_bit1 = nyquist_bit1 * (bit_amplitude / max(nyquist_bit1));
nyquist_bit2 = nyquist_bit2 * (bit_amplitude / max(nyquist_bit2));

nyquist_bit1_filtered = real(ifft(ifftshift(raised_cosine .* channel_filter)));
nyquist_bit2_filtered = real(ifft(ifftshift(raised_cosine .* time_shift .* channel_filter)));

% Plots

plotpulse(nyquist_bit1, fs, 'Raised Cosine Pulse', 250, 2*pulse_len);
plotpulse(nyquist_bit1_filtered, fs, 'Raised Cosine Pulse Passed Through The Channel', 250, 2*pulse_len);

% figure;
% plot(f,raised_cosine);
% xlim([-2*channel_bandwidth  2*channel_bandwidth]);
% title('raised cosine filter pulse in Frequency');

% figure;
% 
% subplot(2, 1, 1);
% plot(t3, nyquist_bit1);
% hold on;
% plot(t3, nyquist_bit2);
% xlim([0 2*pulse_len]);
% title('Two Consecutive Raised Cosine Pulses');
% 
% subplot(2, 1, 2);
% plot(t3, nyquist_bit1);
% hold on;
% plot(t3, nyquist_bit2);
% xlim([0 2*pulse_len]);
% title('Two Consecutive Raised Cosine Pulses Passed Through The Channel');

% extra check for running with octave
is_octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if is_octave
    waitfor(gcf);
end
