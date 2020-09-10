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
        CSV.foreach(@filename, :headers => true) do |row|
            hash = row.to_hash
            if hash[column_name] == criteria
                result << hash
            end
          end
        result
    end

end

class_instance = MyFirstSelect.new("nba_player_data.csv")
p class_instance.where("name","Andre Brown")