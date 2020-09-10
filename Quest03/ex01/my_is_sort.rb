=begin 
    Function definition that takes in an array as a parameter and returns a boolean of true/false
    if array is sorted(asc or desc) or not. 
=end

def my_is_sort (array)
    sorted = array == array.sort || array == array.sort.reverse
end

# To display if the array passed as an argument is sorted (asc or desc) or not
print my_is_sort [1,1,2]
