
=begin 
    function my_join that accepts a string array and separator and returns a string
    joined by the separator
=end
def my_join(array, separator)
    separator = separator.to_s
    array.map do |element|
        if element.instance_of? String
            next
        else
            puts "#{element} is not a string"
            return
        end 
    end
    return array.join(separator)
end

# display the string of the array passed with the separator
print my_join ['Hello','I','am'], '\t'