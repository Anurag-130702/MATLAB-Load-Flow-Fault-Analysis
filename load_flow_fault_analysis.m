clc;
clear;
close all;

% MATLAB-Based Load Flow & Fault Analysis Simulation
% Author: Anurag Panda
% Objective:
% To simulate normal, overload, and fault conditions in a simple electrical system.

%% System Parameters

Vs = 230;          % Source voltage in volts
R_line = 0.5;      % Line resistance in ohms

% Load resistance values in ohms
% Higher resistance = lower current
% Lower resistance = higher current
load_resistance = [100 80 60 40 25 15 10];

%% Normal Load Flow Calculation

current = Vs ./ (R_line + load_resistance);

load_voltage = current .* load_resistance;

power_load = load_voltage .* current;

power_loss = current.^2 .* R_line;

voltage_drop = Vs - load_voltage;

%% Display Results

disp('Load Flow Analysis Results');
disp('--------------------------------------------------');
disp('Load Resistance | Current | Load Voltage | Power Load | Power Loss');
disp('--------------------------------------------------');

for i = 1:length(load_resistance)
    fprintf('%10.2f ohm | %7.2f A | %11.2f V | %10.2f W | %9.2f W\n', ...
        load_resistance(i), current(i), load_voltage(i), power_load(i), power_loss(i));
end

%% Plot 1: Current vs Load Resistance

figure;
plot(load_resistance, current, '-o', 'LineWidth', 2);
xlabel('Load Resistance (Ohm)');
ylabel('Current (A)');
title('Current Variation with Load Resistance');
grid on;

%% Plot 2: Voltage Drop vs Load Resistance

figure;
plot(load_resistance, voltage_drop, '-o', 'LineWidth', 2);
xlabel('Load Resistance (Ohm)');
ylabel('Voltage Drop (V)');
title('Voltage Drop under Different Load Conditions');
grid on;

%% Plot 3: Power Loss vs Load Resistance

figure;
plot(load_resistance, power_loss, '-o', 'LineWidth', 2);
xlabel('Load Resistance (Ohm)');
ylabel('Power Loss (W)');
title('Line Power Loss under Different Load Conditions');
grid on;

%% Overload Condition

overload_threshold = 10;   % Current threshold in amperes

disp(' ');
disp('Overload Detection');
disp('--------------------------------------------------');

for i = 1:length(current)
    if current(i) > overload_threshold
        fprintf('Overload detected at Load Resistance = %.2f ohm, Current = %.2f A\n', ...
            load_resistance(i), current(i));
    else
        fprintf('Normal condition at Load Resistance = %.2f ohm, Current = %.2f A\n', ...
            load_resistance(i), current(i));
    end
end

%% Fault Analysis

% Fault resistance values
% Lower fault resistance means more severe fault
fault_resistance = [5 2 1 0.5 0.1];

fault_current = Vs ./ (R_line + fault_resistance);

disp(' ');
disp('Fault Analysis Results');
disp('--------------------------------------------------');
disp('Fault Resistance | Fault Current');
disp('--------------------------------------------------');

for i = 1:length(fault_resistance)
    fprintf('%14.2f ohm | %12.2f A\n', ...
        fault_resistance(i), fault_current(i));
end

%% Plot 4: Fault Current vs Fault Resistance

figure;
plot(fault_resistance, fault_current, '-o', 'LineWidth', 2);
xlabel('Fault Resistance (Ohm)');
ylabel('Fault Current (A)');
title('Fault Current Variation with Fault Resistance');
grid on;

%% Final Observation

disp(' ');
disp('Observation:');
disp('As load resistance decreases, current increases.');
disp('Higher current causes higher voltage drop and higher power loss.');
disp('During fault conditions, very low fault resistance causes extremely high current.');
disp('This shows the importance of overload detection and protective systems.');