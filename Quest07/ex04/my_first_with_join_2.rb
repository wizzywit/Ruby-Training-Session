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

        @filename = filename_db
    end

    def query 
        result = []
        CSV.foreach(@filename, :headers => true) do |row|
            hash = row.to_hash
            result << hash
          end
        result
    end

    # Join method definition to perform a join on a new table
    def join (column_on_db_a, filename_db_b, column_on_db_b)
        table = []
        CSV.foreach(@filename, :headers => true) do |row|
            hash_1 = row.to_hash
            CSV.foreach(filename_db_b, :headers => true) do |row|
                hash_2 = row.to_hash
                if hash_1[column_on_db_a] == hash_2[column_on_db_b]
                    hash_1.merge!(hash_2)
                    table << hash_1
                end
              end
          end
        if table.size() == 0
            @table << 404
        else
          @table = table
        end
        # p @table
    end

    # Where method to select all rows matching a search param
    def where (column_name, criteria)

        if @table[0] == 404
            "No record found"
        elsif @table.size() == 0
            query()
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
        class_instance = MyFirstSelect.new("nba_player_data.csv")

        # invoke the join method on the class object with another csv file
        class_instance.join("name","nba_players.csv","Player")

        # # select the matching row in the table after the join
        p class_instance.where("birth_state","Illinois")
    end
end
