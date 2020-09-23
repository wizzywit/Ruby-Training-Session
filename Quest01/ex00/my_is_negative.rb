# function that accepts a value and returns 1 if the value is positive or 0 if negative
def my_is_negative(n)
    if n >= 0
        return 1
    else
        return 0
    end
end
    
puts my_is_negative(-5)