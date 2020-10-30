class MySqliteRequest
    attr_accessor :table_name
    def initialize(table_name)
      @table_name = table_name
    end
end