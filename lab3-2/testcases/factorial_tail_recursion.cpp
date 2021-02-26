int factorial (int n, int total)
{
    if (n == 0)
        return total;
    else
        return factorial(n-1, n * total);
}
