# function to determine the absolute of a value, accepts a param and returns the absolute value
def my_abs(nbr)
    if nbr < 0
        nbr = 0 - nbr
        return nbr
    else
        return nbr
    end
end

puts my_abs(-13)