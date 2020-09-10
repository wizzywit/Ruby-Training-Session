=begin 
    function that accepts a string as an argument and returns a string
    with the first word moved to the last, and all single letters word converted to the uppercase
=end

def rostring (string)
    string_to_array = string.split.rotate(1)
    string_to_array.each_with_index do |value, index|
        if value.length == 1
            string_to_array[index] = value.to_s.upcase
        end
    end
    return string_to_array.join(' ')
end

# Sample print to display the rotated string passed to the function
print rostring "This is a test"
