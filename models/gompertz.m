%% GOMPERTZ MODEL
%  Solve logistic model in the spheroid radius.
function r = gompertz(p,t)
    lambda = p(1); K = p(2); r0 = p(3);
    r = K * exp(log(r0 / K) * exp(-lambda/3 * t));
end