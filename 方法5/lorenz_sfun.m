function [sys,x0,str,ts,simStateCompliance] = lorenz_sfun(t,x,u,flag)
    % 主控制开关，根据 Simulink 传进来的 flag 决定调用哪个子函数
    switch flag
        case 0
            [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes;
        case 1
            sys = mdlDerivatives(t,x,u);
        case 3
            sys = mdlOutputs(t,x,u);
        case {2, 4, 9}
            sys = [];
        otherwise
            error(['Unhandled flag = ', num2str(flag)]);
    end
end

function [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes
    % 初始化系统参数
    sizes = simsizes;
    sizes.NumContStates  = 3;  % 3个连续状态变量 (x1, x2, x3)
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 3;  % 输出 3 个状态
    sizes.NumInputs      = 0;  % 不需要外部输入
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
    
    sys = simsizes(sizes);
    x0  = [0; 0; 1e-10];       % 严格设置 3 维列向量初始条件
    str = [];
    ts  = [0 0];               % 连续采样时间
    simStateCompliance = 'UnknownSimState';
end

function sys = mdlDerivatives(t,x,u)
    % 微分方程核心组（严格搬运你方法三成功的那套公式）
    sys = zeros(3,1);
    sys(1) = -8/3 * x(1) + x(2) * x(3);
    sys(2) = -10 * x(2) + 10 * x(3);
    sys(3) = -x(1) * x(2) + 28 * x(2) - x(3);
end

function sys = mdlOutputs(t,x,u)
    % 将计算得到的状态量直接输出
    sys = x;
end
%20230710204