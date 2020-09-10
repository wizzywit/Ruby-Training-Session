=begin
    Class definition, that behaves like a Key-Value database,
    accepting key or Value of any type
=end
class MyRedis

    # Initialize the Instance Variable, to store the hashes
    def initialize
        @database = Hash.new
    end

    # Method to set the key, value pairs
    def my_set key, value
        @database[key] = value
    end

    # Method to get the value by passing in the key
    def my_get key
        @database[key]
    end

    # method definition that accepts multiple arguments of array pairs and
    # sets the key, value pairs on the database for each 
    def my_mset *args

        # validate if the argument is empty
        if args.empty?
            puts "No arguments passed"
            return
        end

        # loops through every argument and sets the value, pair
        args.each do |pair|
            if !pair.is_a? Array 
                puts "Invalid Argument: on my_mset call, #{pair} is not an array"
                return
            elsif pair.size != 2
                puts "Invalid Argument: on my_mset call, #{pair} is not an array of pair: Length must be two(2)"
                return
            end
            my_set(pair[0], pair[1])
        end
    end

    # method to get the value of multiple keys returned as an array
    def my_mget keys

        # validate if argument is not an array
        unless keys.is_a? Array
            puts "Invalid Argument: on my_mget call, #{keys} is not an Array"
            return
        end

        output = []

        # Loops through every element in the keys array and performs a get value operation
        keys.each do |elem|
            if my_get(elem) != nil
                output << my_get(elem)
            end
        end

        output
    end
    
    # method definition to delete a specified key passed in as an array argument
    def my_del keys

        # validates if the keys argument passed is an array
        unless keys.is_a? Array
            puts "Invalid Argument: on my_del call, #{keys} is not an Array"
            return
        end

        # loops through every key and performs a delete operation on the hash
        keys.each do |key|
            if @database.has_key? key
                @database.delete(key)
            else
                puts "Error Deleting Key: #{key}, Key not found in database"
            end
        end
    end


    # method to determine if a key exist on the hah database, returns true if found or false otherwise
    def my_exists key
        if @database.has_key? key
            return true
        else
            return false
        end
    end

    # method definition to rename a key if found otherwise return false
    def my_rename key, new_key
        if my_exists(key)
            @database[new_key] = @database.delete key
        else
            false
        end
    end

    # method definition to backup the database on an external file
    def backup
        File.write("my_dump.rdb", "#{@database}")
    end

    # method definition to read and store the info on the instance variable @database
    def restore
        variable  = eval(File.read("my_dump.rdb"))
        @database = variable
    end

end
my_redis_instance = MyRedis.new
# my_redis_instance.my_mset(['a', 3], ['b', 8], [3, 'i'],)
# # my_redis_instance.my_set('a',3)
# # my_redis_instance.my_del(['a', 7])
# my_redis_instance.my_rename('a', 'z')
# p my_redis_instance.my_exists('z')
# # p my_redis_instance.my_mget(['a'])
# p my_redis_instance.my_get('z')
# my_redis_instance.backup
my_redis_instance.restore
p my_redis_instance.my_get(3)
