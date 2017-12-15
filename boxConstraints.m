%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Autores:
%   Jaime A. Ramírez
%   Lucas S. Batista
%
% Atualização: 16/04/2013
%
% Nota:
%   Garante que x respeite as restrições de caixa (trunca as vairáveis nos
%   limitantes inferior e superior).
% =========================================================================


function x = boxConstraints(x, xlimites)

lb = xlimites(1:2:end); 
ub = xlimites(2:2:end); 

lb = lb(:);
ub = ub(:);

x(x < lb) = lb(x < lb);
x(x > ub) = ub(x > ub);


