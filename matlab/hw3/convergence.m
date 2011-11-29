function [convergenceRate] = convergence(resultArray)
    convergenceRate = [];
    for i=2:length(resultArray)
        convergence = log(resultArray(i))/log(resultArray(i-1));
        convergenceRate = [convergenceRate convergence];
    end
end

