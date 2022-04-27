function s = solveEQ()
    file = input("Escriba el nombre del archivo: ", "s")
    M = dlmread(file, ' ', 0, 0);
    n=length(M);
    b=M(:,n);
    M=M(:,1:(n-1))
    s = M \ b;
    return;
endfunction;