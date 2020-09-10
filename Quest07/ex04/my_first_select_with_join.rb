=begin
    Class definition to perform a join operation on two tables
    it initializes with the first table and joins with another,
    also performing a search, mimking the sql join and select
=end

# importing the csv built in library to clean up the csv file
require 'csv'
require 'benchmark'


# CLass definition
class MyFirstSelectWithJoin

    # initialize all the instance variables and creates the table from the csv
    def initialize (filename_db)

        # Variabe to hold the table data from csv file
        @table = []

        # Loop to create an array of hashes, pushing each hashes to the instance variable
        CSV.foreach(filename_db, :headers => true) do |row|
            @table << row.to_hash
          end
    end

    # Join method definition to perform a join on a new table
    def join (column_on_db_a, filename_db_b, column_on_db_b)

        # Initialize the local variable table
        table = []

        # Loop to the create the records of the new db, pushing every hash to local table variable
        CSV.foreach(filename_db_b, :headers => true) do |row|
            table << row.to_hash
        end

        # Initializing the merge table array
        merge_table = []

        # Looping to compare each hash of the instance table variable and the local/new table variable
        # then pushing the hash that matches to the merge table array
        @table.each do |data|
            table.each do |d|
                if data[column_on_db_a] == d[column_on_db_b]
                    merge_table << data.merge(d)
                end
            end
        end

        # if the merged table array is empty then push 404 to the instance table variable
        # else equate the instance table variable to the merge table variable
        if merge_table.size() == 0
            @table = [404]
        else
            @table = merge_table
        end
    end

    # Where method to select all rows matching a search param
    def where (column_name, criteria)

        # If join returns empty then return no record found else work with the table instance variable
        if @table[0] == 404
            "No record found"
        else
            # ARRAY TO HOLD THE RESULT
            result = []

            # looping the instance variable table and search for a particular criteria and push to the result array
            @table.each do |row|
                if row[column_name] == criteria
                    result << row
                end
            end

            result
        end
    end

end

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
        class_instance = MyFirstSelectWithJoin.new("nba_player_data.csv")

        # invoke the join method on the class object with another csv file
        class_instance.join("name","nba_players.csv","Player")

        # # select the matching row in the table after the join
        p class_instance.where("birth_state","Illinois")
    end
end