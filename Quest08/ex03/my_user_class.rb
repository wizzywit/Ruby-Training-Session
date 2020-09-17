class User

    # Initializing the class instance variables and update the next available ID
    def initialize
        @user = Hash.new
        @file = "db.raw"
        file = File.open(Dir.pwd+'/'+@file)
        last_user = file.readlines.last
        if last_user
            last_user = eval(last_user)
            @id = last_user.keys[0]+1
        else
            @id = 1
        end
        file.close
    end

    # method that accepts a string array argument called user_info in the form
    # "firstname, lastname, age, password, email" and creates a new
    # user inserted into the database
    def create(user_info)
        user_hash = {}
        key_array = %w{firstname lastname age password email}
        user_info.each_with_index do |info, index|
            index == 2? @user[key_array[index]] = info.to_i : @user[key_array[index]] = info.strip
        end
        user_hash[@id] = @user
        user_id = @id
        File.write(Dir.pwd+"/"+@file, user_hash.to_s+"\n", mode: 'a')
        @id += 1

        return user_id
    end

    # Method that accepts a user ID and returns that particular user information as a hash
    def get(user_id)
        user_info = Hash.new
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                if user.keys[0].to_i == user_id
                    user_info = user[user_id]
                end
            end
            f.close
        end
        response(user_info,"User with ID #{user_id} Not Found")
    end

    # Method to return all the users available in the db.raw database in the form of hashes
    def all
        users_info = {}
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                users_info[user.keys[0]] = user[user.keys[0]]
            end
            f.close
        end
        response(users_info,"No record found")
    end

    # Method to Update a particular user, by accepting the user ID, attribute and value
    # It returns the updated user info
    def update(user_id, attribute, value)
        user_info = Hash.new
        users_info = {}
        if attribute == "id"
            abort "Unable to perform an update to a unique field: #{attribute}"
        end
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                if user.keys[0] == user_id
                    if user[user.keys[0]].key? attribute
                        user[user.keys[0]][attribute] = value
                    else
                        abort "No column named #{attribute} present on the database"
                    end
                    users_info[user.keys[0]] = user[user.keys[0]]
                    user_info = user[user.keys[0]]
                else
                    users_info[user.keys[0]] = user[user.keys[0]]
                end
            end
            f.close
        end
        write_to_file(users_info)
        response(user_info,"User with ID #{user_id} Not Found")
    end

    # Method definition that accepts a user ID and deletes it from the database
    def destroy(user_id)
        user_info = Hash.new
        users_info = {}
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                if user["id"] == user_id
                    user_info = {status: 0, message: "User ID: #{user_id} deleted successfully"}
                    next
                else
                    users_info[user.keys[0]] = user.keys[0]
                end
            end
            f.close
        end
        write_to_file(users_info)
        response(user_info,"User with ID #{user_id} Not Found")
    end

    def write_to_file(users_hash, counter = 0)
        users_hash.each do |pri_key,info|
            elem = {}
            elem[pri_key] = info
            if counter == 0
                File.write(Dir.pwd+"/"+@file, elem.to_s+"\n")
            else
                File.write(Dir.pwd+"/"+@file, elem.to_s+"\n", mode: 'a')
            end
            counter +=1
        end
    end

    def response(user_hash, message)
        if user_hash.empty?
            {status: 404, message: message}
        else
            user_hash
        end
    end

end

instance_user = User.new
# p instance_user.create(["wisdom", "praise", 27, "Password", "email@mail.com"])
# p instance_user.get(1)
# p instance_user.all
p instance_user.update(1, "firstname", "john")
# p instance_user.destroy(1)