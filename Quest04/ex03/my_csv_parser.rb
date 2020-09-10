=begin 
    Function definition that accepts two arguments, a filename and a separator,
    and returns an arrays (lines) of arrays (columns).
=end
def my_csv_parser (filename, separator = ',')
    output_array = []
    File.open(Dir.pwd+"/"+filename) do |f|
        f.each_line do |line|
            array = line.split(separator)
            array.map! do |elem| 
                elem.delete("\n")
            end
            output_array << array
        end
        f.close
    end

    output_array
end

print my_csv_parser("data.csv")
