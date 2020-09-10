=begin
    Class definition to perform a join operation on two tables
    it initializes with the first table and joins with another,
    also performing a search, mimking the sql join and select
=end

# importing the csv built in library to clean up the csv file
require 'csv'
require 'benchmark'


# CLass definition
class MyFirstSelect

    # initialize all the instance variables and creates the table from the csv
    def initialize (filename_db)

        # Variabe to hold the table data from csv file
        @table = []

        # Variable to hold the columns data of the csv file
        @columns = []

        # Varaible counter initialization
        counter = 0

        # read the csv file and store n a variable as an array
        file = CSV.read filename_db

        # loop through the array of the file read
        file.each do |row|

            # if it is the first loop then assign to the column instance variable
            # else create the table from the file read
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

    # Join method definition to perform a join on a new table
    def join (column_on_db_a, filename_db_b, column_on_db_b)
        file = CSV.read filename_db_b
        counter = 0
        columns = []
        table = []
        file.each do |row|
            if counter == 0
                columns = row
            else
                each_row = {}
                row.each_with_index do |value,idx|
                   each_row[columns[idx]] = value
                end
                table << each_row
            end
            counter += 1    
        end

        # Array to hold the index of all the rows that was merged
        merged_rows_index = []

        # looping through the new table and merge the rows that match the condition
        # then storing their index on the declared array.
        table.each_with_index do |row, index|
            @table.each_with_index do |first_row, idx|
                if row[column_on_db_b] == first_row[column_on_db_a]
                    @table[idx].merge!(row)
                    merged_rows_index << idx
                end
            end
        end

        # array declaration to hold the new rows that was merged/joined
        new_table = []

        # loop through the merged index and pushing to the new table array
        merged_rows_index.each do |idx|
            new_table << @table[idx]
        end

        # new table array assigned to the instance tablle variable
        @table = new_table
    end

    # Where method to select all rows matching a search param
    def where (column_name, criteria)

        # ARRAY TO HOLD THE RESULT
        result = []

        # looping the instance variable table and search for a particular criteria and push to the result array
        @table.each do |row|
            if row[column_name] == criteria
                result << row
            end
        end

        # return result array if found else return no records found
        if result.size() == 0
            return "No record found"
        else
            result
            # result.each do |x|
            #     print x, "\n"
            # end
        end
    end

end

# # instantiate the class with the initial csv file
# class_instance = MyFirstSelect.new("nba_player_data.csv")

# # invoke the join method on the class object with another csv file
# class_instance.join("name","nba_players.csv","Player")

# # select the matching row in the table after the join
# p class_instance.where("birth_state","Indiana")

def print_time_spent
    time = Benchmark.realtime do
      yield
    end
    puts "Time: #{time.round(2)}"
end

def print_memory_usage
    memory_before = "ps -o rss= -p #{Process.pid}".to_i
    yield
    memory_after = "ps -o rss= -p #{Process.pid}".to_i

    puts "Memory: #{((memory_after - memory_before) / 1024.0).round(2)} MB"
end

print_memory_usage do
    print_time_spent do
        # instantiate the class with the initial csv file
        class_instance = MyFirstSelect.new("nba_player_data.csv")

        # invoke the join method on the class object with another csv file
        class_instance.join("name","nba_players.csv","Player")

        # # select the matching row in the table after the join
        p class_instance.where("birth_state","Illinois")
    end
end