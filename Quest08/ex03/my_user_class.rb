class User

    # Initializing the class instance variables and update the next available ID
    def initialize
        @user = Hash.new
        @file = "db.raw"
        file = File.open(Dir.pwd+'/'+@file)
        last_user = file.readlines.last
        if last_user
            last_user_info = eval(last_user)
            @id = last_user_info["id"]+1
        else
            @id = 1
        end
        file.close
    end

    # method that accepts a string argument called user_info in the form
    # "firstname, lastname, age, password, email" and creates a new
    # user inserted into the database
    def create(user_info)
        user_info = user_info.split(',')
        @user["id"] = @id
        key_array = %w{firstname lastname age password email}
        user_info.each_with_index do |info, index|
            if index == 2
                @user[key_array[index]] = info.strip.to_i
            else
                @user[key_array[index]] = info.strip
            end
        end
        File.write(Dir.pwd+"/"+@file, @user.to_s+"\n", mode: 'a')
        @id += 1

        return @user["id"]
    end

    # Method that accepts a user ID and returns that particular user information as a hash
    def get(user_id)
        user_info = Hash.new
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                if user["id"] == user_id
                    user_info = user
                end
            end
            f.close
        end

        if user_info.empty?
            {status: 404, message:"User with ID #{user_id} Not Found"}
        else
            user_info
        end
    end

    # Method to return all the users available in the db.raw database in the form of hashes
    def all
        users_info = []
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                users_info << user
            end
            f.close
        end

        if users_info.empty?
            {status: 0, message:"No records found"}
        else
            users_info
        end
    end

    # Method to Update a particular user, by accepting the user ID, attribute and value
    # It returns the updated user info
    def update(user_id, attribute, value)
        user_info = Hash.new
        users_info = []
        if attribute == "id"
            abort "Unable to perform an update to a unique field: #{attribute}"
        end
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                if user["id"] == user_id
                    if user.key? attribute
                        user[attribute] = value
                    else
                        abort "No column named #{attribute} present on the database"
                    end
                    users_info << user
                    user_info = user
                else
                    users_info << user
                end
            end
            f.close
        end

        counter = 0
        users_info.each do |info|
            if counter == 0
                File.write(Dir.pwd+"/"+@file, info.to_s+"\n")
            else
                File.write(Dir.pwd+"/"+@file, info.to_s+"\n", mode: 'a')
            end
            counter +=1
        end

        if user_info.empty?
            {status: 404, message:"User with ID #{user_id} Not Found"}
        else
            user_info
        end
    end

    # Method definition that accepts a user ID and deletes it from the database
    def destroy(user_id)
        user_info = Hash.new
        users_info = []
        File.open(Dir.pwd+"/"+@file) do |f|
            f.each_line do |line|
                user = eval(line)
                if user["id"] == user_id
                    user_info = {status: 0, message: "User ID: #{user_id} deleted successfully"}
                    next
                else
                    users_info << user
                end
            end
            f.close
        end

        counter = 0
        users_info.each do |info|
            if counter == 0
                File.write(Dir.pwd+"/"+@file, info.to_s+"\n")
            else
                File.write(Dir.pwd+"/"+@file, info.to_s+"\n", mode: 'a')
            end
            counter +=1
        end

        if user_info.empty?
            {status: 404, message:"User with ID #{user_id} Not Found"}
        else
            user_info
        end

    end

end

instance_user = User.new
p instance_user.create("wisdom, praise, 24, Jesuschrist01, wisdompraise968@gmail.com")
# p instance_user.get(1)
# p instance_user.all
# p instance_user.update(1, "id", "chima")
p instance_user.destroy(1)