%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia El�trica
%
% Autores:
%   Jaime A. Ram�rez
%   Lucas S. Batista
%
% Atualiza��o: 16/04/2013
%
% Nota:
%   Garante que x respeite as restri��es de caixa (trunca as vair�veis nos
%   limitantes inferior e superior).
% =========================================================================


function x = boxConstraints(x, xlimites)

lb = xlimites(1:2:end); 
ub = xlimites(2:2:end); 

lb = lb(:);
ub = ub(:);

x(x < lb) = lb(x < lb);
x(x > ub) = ub(x > ub);


