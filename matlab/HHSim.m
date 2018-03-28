% sim

% noiseStd = [1 0 0 0]; % ... Measurment noise
delta = 0.01; % integration step [ms]
Vth = 30; % count spikes when voltage goes above Vth

V =	-71;
n = 0.0147; 
h = 0.7497;
B = 0.0326;

gB = 3.5;
EB = -74.8;
VBth = -2.2;
SB = 9.6;
tauB = 64;
I = 2;
mNoise = 0.1;

s0 = [V; n; h; B];

params = [gB; EB; VBth; SB; tauB; I; mNoise];

%% Run Sim
TOTAL_TIME = 1e3 * 1/delta; % time steps to simulate (ms * fs)
states = [s0; params]; % initial states
sim = zeros(numel(states), TOTAL_TIME); % to hold simulation results
% noise = [noiseStd(:) * mNoise; zeros(numel(params), 1)];

% [t, sim] = ode23(@HH_dynamics, [0 1e3], states); sim = sim';

sim(:, 1) = states;
for t = 2:TOTAL_TIME
	sim(:, t) = HH_stateTrnsn(sim(:, t-1), t, delta, []);
end
t = (1:TOTAL_TIME) * delta;

% for t = 1:TOTAL_TIME
% 	dS = HH_dynamics(states); % dynamics
% 	states = states + dS * delta + noise .* randn(size(states)); % updated states
% 	too_high = states(2:4) > 1; states(too_high) = 1;
% 	too_low = states(2:4) < 0; states(too_low) = 0;
% 	sim(:, t) = states;
% end

%% Plot Results
figure(99); fullwidth()
ax = subplot(8,1,2:7);
% tt = (1:TOTAL_TIME) * delta;
plot(t, sim(1,:)); ylabel('Voltage [mV]'); xlabel('Time [ms]'); 
hold on; plot([0 t(end)],Vth *  [1 1], '--', 'color', .5 * [1 1 1]); hold off
spikes = [false logical((sim(1,1:end-1) < Vth) .* sim(1,2:end) > Vth)];
hold on; plot(t(spikes), sim(1,spikes), 'r*'); hold off;

subplot(8,1,1);
spiketimes = find(spikes);
spikeT = t(spikes);
plot([spikeT(:) spikeT(:)]', [zeros(size(spikeT(:))) ones(size(spikeT(:)))]', 'color', lines(1))
xlim(get(ax, 'xlim'))
yticks([]); xticks([]);
