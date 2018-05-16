function [s0, boundsStruct] = HH_stateBounds()
% STATES = (V, n, h, B, gB, EB, VBth, SB, tauB, I) 

s0 = [	-71;	... % V
		0.0147; ...	% n
		0.7497; ...	% h
		0.0326; ...	% B
		];
	
% gB = 3.5;
% EB = -74.8;
% VBth = -2.2;
% SB = 9.6;
% tauB = 64;
% I = 2;
% EK = -95;
% gK = 7;


paramBounds = {...
% 				'gB',	[3.5,	3.5,	1];	... % (0 10)
				'EB',	[-90,	-60,	2];	...	% (110 110)
% 				'VBth', [-5,	0,		1];	... % (-95 5)
% 				'SB',	[5,		15,		1];	... % (-10 10)
% 				'tauB', [64,	64,		1];	... % (0 80)
% 				'I',	[1.5,		2.5,		1];	... % (-5 5)
				'mNoise', [0,	0.5,		1];	... 
% 				'EK',	[-115,	-50,	1]; ...
% 				'gK',	[0,		15,		1]; ...
				};

boundsStruct = cell2struct(paramBounds(:, 2), paramBounds(:, 1));

end
