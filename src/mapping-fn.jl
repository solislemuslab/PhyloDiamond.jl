## Julia script to map CF table to a values
## Claudia March 2022
## Note: this is just pseudo code for now
##       we also want to put this script into a function with cf,N as input arguments and mean_a as output

## Input:
cf = DataFrame(CSV.File("N2222_expCF.txt"))
N = [("A","B"),("C","D"),("E","F"),("G","H")]

## create vector a
a = zeros(57)

## create vector that counts how many rows are mapped to each a value
c = ones(57)


## note: the names of the functions can be changed (I did not have your functions when I wrote this)
for row in eachrow(cf)
    taxa = collect(row[1:4]) ## taxa for that quartet
    cfs = collect(row[5:7])  ## CFs, not sure if they are in columns 5,6,7
    n = get_n_quartet(taxa, N) ## returns the n=(1,2,1,0) quartet vector e.g.
    ind = which_a(n) ## returns the indices in the a vector for that quartet vector e.g. (34,35,36). The order is major, minor, minor
    ord_cfs = cfs_in_order(taxa, cfs, N) ## returns the CFs from the table (cfs) in the order major, minor, minor

    if a[ind] .== 0 ## we have not added these a values before
        a[ind] = ord_cfs ## we map the CFs values to the a values in the order major, minor, minor
    else 
        a[ind] += ord_cfs ## we add the CFs values, and we will divide by the c vector at the end (to get the average)
        c[ind] += 1  ## add one row that is mapped to this a values
    end
end

mean_a = a./c ## divide a by c element-wise