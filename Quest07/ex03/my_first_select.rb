# Import the csv module to clean up the csv file
require 'csv'

# Class definition begins
class MyFirstSelect


    # Intialize the instance variables (table) and columns 
    def initialize (filename_db)

        # Initialize instance variable table
        @table = []

        # Initialize instance variable columns
        @columns = []

        # Initialize loop counter
        counter = 0

        # read csv file and assigned to file local variable
        file = CSV.parse(filename_db,liberal_parsing: :true, quote_char: "\"")

        # Iterate on every element/line in the file gotten
        file.each do |row|

            # assign columns to the first row/line of the file
            # else
            if counter == 0
                @columns = row
            else
                each_row = {}
                row.each_with_index do |value,idx|
                   each_row[@columns[idx]] = value
                end
                @table << each_row
            end
            counter += 1    
        end
    end

    def where (column_name, criteria)
        result = []
        @table.each do |row|
            if row[column_name] == criteria
                search = row.values.join(",")
                row = []
                row << search
                result << row
            end
        end
        result
    end

end

class_instance = MyFirstSelect.new(File.read("nba_player_data.csv"))
p class_instance.where("name","Mahmoud Abdul-Rauf")