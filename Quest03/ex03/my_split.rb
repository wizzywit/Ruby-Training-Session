
=begin 
    function definition that accepts two params (string, charset), returns an array making
    making use of every character in the charset as a delimeter, removing every empty string in the array
=end

def my_split (string, charset)
    charset_array = charset.split('')
    # print charset_array
    result = string.split(Regexp.union(charset_array))
    result = result.select do |elem| 
        elem != ""
    end
    return result
end

# Display output of a test case, by passing in the string and charset as an argument
print my_split("abc def gh\t!", "def ")