function [errors] = hw1_prob3
    global lookup;
    lookup = zeros(60,60);
    
    errors = zeros(1,60);
    for i=1:60
        errors(i) = recursiveError(0,i,1);
    end
   
   
    return;
end

%computes the error of calculating fRecursive and fNormal
function [answer] = recursiveError(j, k, x0)
    recursive = fRecursive(j, k, x0);
    normal = fNormal(j, k, x0);
    answer = abs(recursive - normal);
    return;
end

%computes sin(x0 + (j-k)*pi/3) recursively
function [answer] = fRecursive(j, k, x0)
    global lookup;
  
    %check base case
    if k == 0
        answer = sin(x0 + j*(pi/3));
        return;
    else
        %check to see if the answer is already computed
        %store result of j,k in j+1,k because MATLAB starts indexes at 1
        if j < 60
            if lookup(j+1,k) ~= 0
                answer = lookup(j+1,k);
                return;
            end
        end
        
        %otherwise, recurse
        answer = fRecursive(j, k-1, x0) - fRecursive(j+1, k-1, x0);
        
        %add answer to lookup table
        if j < 60
            lookup(j+1,k) = answer; 
        end
        return;
    end
end

%computes sin(x0 + (j-k)*pi/3) normally
function [answer] = fNormal(j, k, x0)
    answer = sin(x0 + (j-k)*pi/3);
    return;
end
    