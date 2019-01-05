function [xc, fEvals] = Newton(f, x0, delta, fEvalMax)
% f is a HANDLE to a continuous function, f(x), of a single variable.
% x0 is an initial guess to a root of f.
% delta is a positive real number.
% fEvalsMax is a positive integer >= 2 that indicates the maximum
% number of f-evaluations allowed.
%
% Newton's method is repeatedly applied until the current iterate, xc,
% has the property that |f(xc)| <= delta. If that is not the case
% after fEvalsMax function evaluations, then xc is the current iterate.
%
% This routine computes the derivative of f at each iterate xc by
% using a central difference approximation with small perturbation size.
%
% fEvals is the number of f-evaluations required to obtain xc.

% Test fEvalsMax Validity
if fEvalMax < 2
    error('The maximum number of allowed evaluations must be greater than or equal to 2.')
end

% Initializations
h = 1*10^-6; % step size for derivative
fEvals = 0;

% Iterate Newton's Method Until a Root is Found
while abs(f(x0)) > abs(delta) && fEvals < fEvalMax
    
    fprime = (f(x0+h) - f(x0-h))/(2*h); % derivative central difference
    xc = x0 - f(x0)/fprime; % find new point closer to root
    
    x0 = xc; % reset x0 for next iteration
    fEvals = fEvals + 1; % count up number of evaluations
    
end
end