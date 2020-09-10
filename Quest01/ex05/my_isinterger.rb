# function definition that accepts a param and returns 1 if the value is an integer or 0 otherwise
def my_isinteger(n)
    if n.is_a? Integer
        return 1
    else 
        return 0
    end 
end

# display 1 is the value is an integer and 0 otherwise
puts my_isinteger(7)