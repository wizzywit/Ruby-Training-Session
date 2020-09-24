=begin 
    Function definition that accepts two arguments, a filename and a separator,
    and returns an arrays (lines) of arrays (columns).
=end
def my_csv_parser (csv_string, separator = ',')
    output_array = []
    csv_string.each_line do |line|
        array = line.split(separator)
        array.map! do |elem| 
            elem.delete("\n")
        end
        output_array << array
    end
    output_array
end

print my_csv_parser("a,b,c,e\n1,2,3,4\n")
