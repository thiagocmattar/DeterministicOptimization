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
%   Aproxima o ponto de �timo (minimiza��o) de um problema irrestrito
%   usando o Algoritmo do Gradiente (VERS�O SIMPLES - MERAMENTE ILUSTRATIVA).
% =========================================================================


function newtonMethod (fun, x, e, xlimites)

%
% Sintaxe
% gradienteMethod(fun, x, e, xlimites)
% fun     : fun��o objetivo
% x       : vetor solu��o inicial [x1 x2 ... xn]
% e       : precis�o adotada pelo usu�rio
% xlimites: limites inferior e superior das vari�veis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
%
% Exemplo
% newtonMethod(@fobj1, [+3.0 +3.0], 0.01, [0 4 0 4])
% newtonMethod(@fobj2, [-1.0 +1.5], 0.01, [-1.5 1.5 -1.0 1.5])
%


% Contador de itera��es do m�todo
k = 0;

% Garante que x seja um vetor coluna
x = x(:);

% Garante que x respeite as restri��es de caixa
x = boxConstraints(x, xlimites);

g = gradienteVector(fun, x);  % Estima o grandiente da fun��o no ponto x
h = hessiana(fun,x);          % Estima a hessiana da fun�ao no ponto x
d = -inv(h)*g;                % Determina a dire��o de busca

% Estima o valor de 'alpha^*' usando o Algoritmo da Se��o �urea
alpha = unidimensionalOptimization(fun, x, d);

% Armazena o caminho percorrido em dire��o ao �timo
caminho(k+1,:) = [x' feval(fun, x)];

% Imprime o resultado da busca encontrado at� a itera��o k
output(fun, caminho, k, xlimites); 


% Crit�rio de parada: condi��o necess�ria de primeira ordem (||g|| = 0)
while (norm(g) >= e)            
    x = x + alpha*d;                 % Determina a nova solu��o  
    x = boxConstraints(x, xlimites); % Verifica a restri��o de caixa
    g = gradienteVector(fun, x);% Calcula o grandiente da fun��o no ponto x
    h = hessiana(fun,x);          % Estima a hessiana da fun�ao no ponto x
    d = -inv(h)*g;                     % Determina a dire��o de busca    
    k = k + 1;                  % Atualiza o contador
    
    % Estima um novo valor para 'alpha^*'
    alpha = unidimensionalOptimization(fun, x, d); 
    
    % Armazena o caminho percorrido em dire��o ao �timo
    caminho(k+1,:) = [x' feval(fun, x)];
    
    % Atualiza o percusso em dire��o ao �timo
    output(fun, caminho, k, xlimites);    
end
fprintf('\n')

figure
plot(0:k,caminho(:,end),'k-','linewidth',2)
xlabel('N�mero de itera��es')
ylabel('Valor da fun��o objectivo')
