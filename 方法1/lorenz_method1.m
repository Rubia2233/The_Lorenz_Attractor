function lorenz_method1()
    close all;
    
    % 1. 定义仿真时间范围 (0 到 100 秒)
    tspan = [0 100];
    
    % 2. 严格设置 3 维初始条件
    x0 = [0; 0; 1e-10];
    
    % 3. 使用 ode45 求解器进行底层算法求解
    [t, x] = ode45(@lorenz_equations, tspan, x0);
    x1 = x(:, 1);
    x2 = x(:, 2);
    x3 = x(:, 3);
    
    %% ================= 图 1：状态曲线 (State Trajectories) =================
    figure('Name', 'Method 1 - State Trajectories', 'NumberTitle', 'off');
    
    % 第 1 幅子图：x1 随时间的变化
    subplot(3, 1, 1);
    plot(t, x1, 'Color', [0.85, 0.33, 0.1], 'LineWidth', 1.1); % 暖橘色
    grid on;
    ylabel('x_1(t)');
    title('Lorenz System State Trajectories (\tau = 100s)');
    
    % 第 2 幅子图：x2 随时间的变化
    subplot(3, 1, 2);
    plot(t, x2, 'Color', [0, 0.45, 0.74], 'LineWidth', 1.1);  % 科技蓝
    grid on;
    ylabel('x_2(t)');
    
    % 第 3 幅子图：x3 随时间的变化
    subplot(3, 1, 3);
    plot(t, x3, 'Color', [0.47, 0.67, 0.19], 'LineWidth', 1.1); % 草绿色
    grid on;
    xlabel('Time (seconds)');
    ylabel('x_3(t)');

    %% ================= 图 2：相平面图 (3D Phase Plane) =================
    figure('Name', 'Method 1 - 3D Phase Plane', 'NumberTitle', 'off');
    plot3(x1, x2, x3, 'Color', [0, 0.2, 0.6], 'LineWidth', 1.3); 
    grid on;
    xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
    title('Lorenz System 3D Phase Plane (Method 1 - Pure M-File)');
end

% 底层微分方程公式组
function dxdt = lorenz_equations(t, x)
    dxdt = zeros(3,1);
    dxdt(1) = -8/3 * x(1) + x(2) * x(3);
    dxdt(2) = -10 * x(2) + 10 * x(3);
    dxdt(3) = -x(1) * x(2) + 28 * x(2) - x(3);
end
%20230710204 23自动化2 丁朝文