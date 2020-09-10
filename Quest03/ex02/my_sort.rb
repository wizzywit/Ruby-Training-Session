=begin 
    funstion definition that accepts two params, the first and array and the second the order
    of sorting, and returns the sorted array
=end

def my_sort (array,order)
    if order == :asc
        return array.sort
    elsif order == :desc
        return array.sort.reverse
    else
        return array
    end
end

# display the sorted array by passing the array and the sorting order(asc, desc)
print my_sort [1,7,9,2,-1], :asc
