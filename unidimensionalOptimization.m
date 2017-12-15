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
%   Estima o valor ótimo de 'alpha'.
% =========================================================================


function alpha = unidimensionalOptimization(fun, x, d)
    
    %Determinação do intervalo
    a = 0;
    s = 1e-3;
    b = s;
    x = x(:);
    d = d(:);
    tetaA = feval(fun,x+a*d);
    tetaB = feval(fun,x+b*d);
    nfe = 2;
    while(tetaB<tetaA)
        a = b;
        tetaA = tetaB;
        b = 2*b;
        tetaB = feval(fun,x+b*d);
        nfe = nfe + 1;
    end
    if(nfe<=3)
        a = 0;
    else
        a = a/2;
    end
    
    %Método da seção áurea
    nA = 0.618;
    xa = b - nA*(b-a);
    xb = a + nA*(b-a);
    eps = 1e-3;
    tetaA = feval(fun,x+xa*d);
    tetaB = feval(fun,x+xb*d);
    while((b-a)>eps)
        if(tetaA>tetaB)
            a = xa;
            xa = xb;
            xb = a + nA*(b-a);
            tetaA = tetaB;
            tetaB = feval(fun,x+xb*d);
        else
            b = xb;
            xb = xa;
            xa = b - nA*(b-a);
            tetaB = tetaA;
            tetaA = feval(fun,x+xa*d);
        end
    end
    alpha = (a+b)/2;    
end

% switch func2str(fun)
%     case 'fobj1'
%         alpha = 0.1;
%     case 'fobj2'
%         alpha = 0.001;
%     otherwise
%         disp('Função não definida!')



