%*********************************************************************
% Initialization
%*********************************************************************
openinout;
Tcycle = 0.01;
lengthExp = 40;
N0 = lengthExp/Tcycle;
Data = zeros(N0, 4);
DataCommands = zeros(N0, 1);
cond = 1;
i = 1;

%*********************************************************************
% Parameters
%*********************************************************************
upper_limit = 1.7; % saturation
lower_limit = -1.6;

upper_dead_zone = 0.8; % dead zone
lower_dead_zone = -0.7;

[in1, in2, in3, in4, in5, in6, in7, in8] = anain;

reference = [6.73339843750000;    % position
            -0.0146484375000000;  % velocity
            5.27832031250000;     % angle
            -0.0146484375000000]; % angular velocity

K = [-1   -1.8497  -66.8128  -14.5675];

i_a = 5; % input current for the swing up strategy
         
%*********************************************************************
% Save in real time
%*********************************************************************
while cond == 1
	tic
	[in1, in2, in3, in4, in5, in6, in7, in8] = anain;

	% Control law
	Data(i, 1) = in1; % position
	Data(i, 2) = in2; % velocity
	Data(i, 3) = in3; % angle
	Data(i, 4) = in4; % angular velocity
    
    states = [in1;
              in2;
              in3;
              in4];
     
     % Regulation when the pendulum is close to the equilibrium point
     if (in3 >= 5.05625 && in3 <= 5.45625)
        reference(1) = in1;
        error = reference - states;
        u = K * (error);

        % We add the dead zone and if the input is to high, 
        % we set the input to the limit value of the saturation
        if u >= 0
            input = u + upper_dead_zone;
            if input >= upper_limit
                input = upper_limit;
                u = upper_limit - upper_dead_zone;
            end
        elseif u < 0
            input = u + lower_dead_zone;
            if input <= lower_limit
                input = lower_limit;
                u = lower_limit - lower_dead_zone;
            end
        end
    
     % Swing Up by giving a impulse when the pendulum is close to 0 (down)
     % in the opposite direction
     elseif (in4 > 0 && (in3 > 9.7 || in3 < 0.3))
        input = i_a;
     elseif (in4 < 0 && (in3 > 9.7 || in3 < 0.3))
        input = -i_a;
     else
        input = 0;
     end


    anaout(input, 0);
    DataCommands(i) = u;
    
	i = i + 1;
	t = toc;
	if t > Tcycle
		disp('Sampling time to small');
	else
		while toc <= Tcycle
		end
	end
	if i == N0 + 1
		cond = 0;
	end
end

%*********************************************************************
% Plot
%*********************************************************************
closeinout;
i = i - 1;
time = 0:Tcycle:(i - 1) * Tcycle;

figure
plot(time, Data(:, 1), time, DataCommands(:), time, Data(:, 2));
