# function that accepts two string params, the first is the haystack and the second 
# being the needle and returns the position of the needle in the haystack, if not found returns -1
def my_string_index(haystack, needle)
    index = haystack.index(needle)
    if index
        return index
    else
        return -1
    end

end

puts my_string_index("hello", "ll")