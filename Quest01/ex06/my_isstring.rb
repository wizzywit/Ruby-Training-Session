# function definition that accepts a param and returns 1 if the value is a string or 0 otherwise

def my_isstring(n)
    if n.is_a? String
        return 1
    else
        return 0
    end
end

# display 1 is argument passed is a string or 0 otherwise
puts my_isstring("Hello World")