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
%   Estima o gradiente de uma fun��o no ponto especificado.
% =========================================================================


function h = hessiana (fun, x)
    n = length(x);
    delta = 1e-3;
    e = eye(n);
    h = zeros(n,1);
    x = x(:);
    for i = 1:n
        h(:,i) = (gradienteVector(fun, x+delta*e(:,i))-gradienteVector(fun, x))/delta; %Fi <- [g(x+delta*ei) - g(x)]/delta;
    end
    %h = h;
    


% Gradiente anal�tico da fun��o 'fun'
% switch func2str(fun)
%     case 'fobj1'
%         g(1) = 4*(x(1)-2)^3 + 2*(x(1)-2*x(2));
%         g(2) = -4*(x(1)-2*x(2));
%     case 'fobj2'
%         g(1) = -400*x(1)*(x(2)-x(1)^2)^2 - 2*(1-x(1));
%         g(2) = 200*(x(2)-x(1)^2);
%     otherwise
%         disp('Vetor gradiente n�o definido!')
% end
% 
% g = g(:);



