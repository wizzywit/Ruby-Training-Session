=begin
    function whch take a hash with all marks for a test and returns average mark
    for the test
=end
def class_average(class_results)

    # sum to hold the sum of values
    sum = 0

    # validate if it is a valid hash passed
    if !class_results.is_a? Hash
        print "Pass in a hash value"
        return
    end

    # validate if the hash is empty
    if class_results.empty?
        print 0.0
        return
    end


    # loop through every value, validate each values and add to sum
    class_results.values.each do |value| 

        # check if any value is not an integer or float
        if !value.is_a? Integer and !value.is_a? Float
            print "#{value} is not a valid Number"
            return
        end
        sum += value
    end

    # caluculate the average
    avg = sum.to_f/class_results.size

end

print class_average ({"john"=>67})

