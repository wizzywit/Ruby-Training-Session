require 'csv'

class MyFirstSelect
    def initialize (filename_db)
        @table = []
        @columns = []

        @counter = 0

        file = CSV.read filename_db
        file.each do |row|
            if @counter == 0
                @columns = row
            else
                each_row = {}
                row.each_with_index do |value,idx|
                   each_row[@columns[idx]] = value
                end
                @table << each_row
            end
            @counter += 1    
        end
    end

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

        # p table
        merged_rows_index = []
        table.each_with_index do |row, index|
            @table.each_with_index do |first_row, idx|
                if row[column_on_db_b] == first_row[column_on_db_a]
                    @table[idx].merge!(row)
                    merged_rows_index << idx
                end
            end
        end

        new_table = []
        merged_rows_index.each do |idx|
            new_table << @table[idx]
        end

        # p new_table.size()
        @table = new_table
        # p @table
    end


    def where (column_name, criteria)
        result = []
        @table.each do |row|
            if row[column_name] == criteria
                result << row
            end
        end
        result.size()
    end

end

class_instance = MyFirstSelect.new("nba_player_data.csv")
class_instance.join("name","nba_players.csv","Player")
p class_instance.where("birth_state","Indiana")