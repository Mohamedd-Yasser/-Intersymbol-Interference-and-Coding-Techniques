function [] = plotpulse(signal, fs, maintitle, max_freq, time_length)
% Plot a signal in both time and frequency domain on top of each other
%
%  Inputs:
%    signal:       Self explanatory
%    fs:           Sampling frequency
%    maintitle:    The title for the whole subplot
%    max_freq:     Limit for xlim in frequency
%    time_length:  Limit for xlim in time

    t_end = length(signal) / fs;
    t = linspace(0, t_end, t_end * fs);

    fvec = linspace(-fs/2, fs/2, length(signal));
    signal_ft = abs(fftshift(fft(signal)));

    %figure('Name', maintitle);
    fig = figure('units', 'normalized', 'outerposition', [0 0 1 1], 'Name', maintitle);
    
    subplot(2, 1, 1);
    plot(t, signal);
    xlabel('Time (s)');
    xlim([0 time_length]);

    subplot(2, 1, 2);
    plot(fvec/1000, signal_ft);
    xlabel('Frequency (kHz)');
    xlim([-max_freq max_freq]);

    % add a main title to the whole subplot
    axes('Visible', 'off');
    title(maintitle, 'Visible', 'on', 'fontsize', 15);
        
    % save figure as a picture
    % print(fig, strcat('plots/', num2str(fig.Number), ') ', maintitle), '-dpng', '-r0');
end
