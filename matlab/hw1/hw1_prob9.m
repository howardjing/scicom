function [output1 output2 output3 output4 output5 output6] = hw1_prob9

    length = 100;
    %lookup table for fib and pib
    global fibLook pibLook;
    global backwardsFibLook backwardsPibLook;
    global backwardsFibLookSingle backwardsPibLookSingle;
    
    fibLook = zeros(1, length);
    pibLook = zeros(1, length);
    
    backwardsFibLook = zeros(length,length);
    backwardsPibLook = zeros(length,length);
    
    backwardsFibLookSingle = zeros(length, length);
    backwardsPibLookSingle = zeros(length, length);
    
    fib(length);
    pib(length);
    
    output1 = fibLook;
    output2 = pibLook;
    
    for i=length:-1:1
        backwardsFib(i,1);
        backwardsPib(i,1);
        
        backwardsFibSingle(i,1);
        backwardsPibSingle(i,1);
    end
    output3 = abs(backwardsFibLook(:,1)-fibLook(1,1))';
    output4 = abs(backwardsPibLook(:,1)-pibLook(1,1))';
    
    output5 = abs(backwardsFibLookSingle(:,1)-fibLook(1,1))';
    output6 = abs(backwardsPibLookSingle(:,1)-pibLook(1,1))';    
    
    
    figure
    plot([1:length],output3,'r--')
    %hold on
    %plot([1:length],output5,'b-')
    %hold off
    return;
end

function [answer] = fib(k)
    global fibLook;
    
    %base case
    if k <= 2
        answer = 1;
        fibLook(1,k) = answer;
        return;
    else
        %check if we already computed the answer
        if fibLook(1,k) ~= 0
            answer = fibLook(1,k);
            return;
        end
        
        %otherwise recurse and record in lookup table
        answer = fib(k-1) + fib(k-2);
        fibLook(1, k) = answer;
        return;
    end
end

function [answer] = pib(k)
    global pibLook;
    
    %base case
    if k <= 2
        answer = 1;
        pibLook(1,k) = answer;
        return;
    else
        %check if we already computed the answer
        if pibLook(1,k) ~= 0
            answer = pibLook(1,k);
            return;
        end
        
        %otherwise recurse and record in lookup table
        c = 1 + sqrt(3)/100;
        answer = c*pib(k-1) + pib(k-2);
        pibLook(1, k) = answer;
        return;
    end
end

function [answer] = backwardsFib(j, k) % j for row, k for column
    global backwardsFibLook;
    global fibLook;
    
    %base case
    if (k == j) || (k == j-1)
        answer = fibLook(1,k);
        backwardsFibLook(j,k) = answer;
        return;
    else
        %check if we have already computed the answer
        if backwardsFibLook(j,k) ~= 0
            answer = backwardsFibLook(j,k);
            return;
        end
        
        %otherwise recurse and record in lookup table
        answer = backwardsFib(j,k+2) - backwardsFib(j,k+1);
        backwardsFibLook(j,k) = answer;
        return;
    end
end

function [answer] = backwardsPib(j, k) % j for row, k for column
    global backwardsPibLook;
    global pibLook;
    
    %base case
    if (k == j) || (k == j-1)
        answer = pibLook(1,k);
        backwardsPibLook(j,k) = answer;
        return;
    else
        %check if we have already computed the answer
        if backwardsPibLook(j,k) ~= 0
            answer = backwardsPibLook(j,k);
            return;
        end
        
        %otherwise recurse and record in lookup table
        c = 1 + sqrt(3)/100;
        answer = backwardsPib(j,k+2) - c*backwardsPib(j,k+1);
        backwardsPibLook(j,k) = answer;
        return;
    end
end

%single precision backwards fib
function [answer] = backwardsFibSingle(j, k) % j for row, k for column
    global backwardsFibLookSingle;
    global fibLook;
    
    %base case
    if (k == j) || (k == j-1)
        answer = fibLook(1,k);
        backwardsFibLookSingle(j,k) = answer;
        return;
    else
        %check if we have already computed the answer
        if backwardsFibLookSingle(j,k) ~= 0
            answer = backwardsFibLookSingle(j,k);
            return;
        end
        
        %otherwise recurse and record in lookup table
        answer = single(backwardsFibSingle(j,k+2) - backwardsFibSingle(j,k+1));
        backwardsFibLookSingle(j,k) = answer;
        return;
    end
end

%single precision backwards pib
function [answer] = backwardsPibSingle(j, k) % j for row, k for column
    global backwardsPibLookSingle;
    global pibLook;
    
    %base case
    if (k == j) || (k == j-1)
        answer = pibLook(1,k);
        backwardsPibLookSingle(j,k) = answer;
        return;
    else
        %check if we have already computed the answer
        if backwardsPibLookSingle(j,k) ~= 0
            answer = backwardsPibLookSingle(j,k);
            return;
        end
        
        %otherwise recurse and record in lookup table
        answer = single(backwardsPibSingle(j,k+2) - backwardsPibSingle(j,k+1));
        backwardsPibLookSingle(j,k) = answer;
        return;
    end
end


