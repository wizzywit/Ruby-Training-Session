# Import the csv module to clean up the csv file
require 'csv'

# Class definition begins
class MyFirstSelect


    # Intialize the instance variables (table) and columns 
    def initialize (filename_db)
        # Initialize instance variable table
        @filename = filename_db
    end

    def where (column_name, criteria)
        result = []
        CSV.parse(@filename, :headers => true, liberal_parsing: :true, quote_char: "\'") do |row|
            hash = row.to_hash
            if hash[column_name] == criteria
                result << hash
            end
          end
        result
    end

end

class_instance = MyFirstSelect.new("name,year_start,year_end,position,height,weight,birth_date,college\nAlaa Abdelnaby,1991,1995,F-C,6-10,240,'June 24, 1968',Duke University\nZaid Abdul-Aziz,1969,1978,C-F,6-9,235,'April 7, 1946',Iowa State University\nKareem Abdul-Jabbar,1970,1989,C,7-2,225,'April 16, 1947','University of California, Los Angeles
    Mahmoud Abdul-Rauf,1991,2001,G,6-1,162,'March 9, 1969',Louisiana State University\n")
p class_instance.where("name","Kareem Abdul-Jabbar")