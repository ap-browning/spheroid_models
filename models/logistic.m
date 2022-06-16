%% LOGISTIC_MODEL
%  Solve logistic model in the spheroid radius.
function r = logistic(p,t)
    lambda = p(1); K = p(2); r0 = p(3);
    r = K ./ (1 + (K / r0 - 1) * exp(-lambda / 3 * t));
end