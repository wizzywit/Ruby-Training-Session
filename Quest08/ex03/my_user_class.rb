class User

    # Initializing the class instance variables and update the next available ID
    def initialize
        @user = Hash.new
        @file = "db.raw"
        

        # read the last line of the db file
        last_user = read().last

        # if the db is not empty asign the incremented id of the last record to the ID instance variable
        # otherwise assign 1 to instance variable ID
        if last_user
            last_user = eval(last_user)
            @id = last_user.keys[0]+1
        else
            @id = 1
        end
    end

    # method that accepts a string array argument called user_info in the form
    # [firstname, lastname, age, password, email] and creates a new
    # user inserted into the database
    def create(user_info)

        # user hash varaible to hold the hash of the newly created user
        user_hash = {}

        # column array for the table
        key_array = %w{firstname lastname age password email}

        # creating the new user info to be assigned to the user hash
        user_info.each_with_index do |info, index|
            index == 2? @user[key_array[index]] = info.to_i : @user[key_array[index]] = info.strip
        end

        # creates a hash of id => user_info
        user_hash[@id] = @user

        # hold the current saved user ID
        user_id = @id

        # save/write the user hash to file
        File.write(Dir.pwd+"/"+@file, user_hash.to_s+"\n", mode: 'a')
        # File.write('C:\Users\praise.wisdom\Documents\db.raw', user_hash.to_s+"\n")

        # increment the current instance variable ID
        @id += 1

        # return the current saved user ID
        user_id
    end

    # method read to read from the database
    def read
        file = File.open(Dir.pwd+'/'+@file)

        # read the lines of the db file into an array
        users = file.readlines
        file.close
        users
    end

    # Method that accepts a user ID and returns that particular user information as a hash
    def get(user_id)
        user_info = Hash.new
        read().each do |line|
            user = eval(line)
            if user.keys[0].to_i == user_id
                user_info = user[user_id]
            end
        end

        response(user_info,"User with ID #{user_id} Not Found")
    end

    # Method to return all the users available in the db.raw database in the form of hashes
    def all
        users_info = {}
        read().each do |line|
            user = eval(line)
            users_info[user.keys[0]] = user[user.keys[0]]
        end

        response(users_info,"No record found")
    end

    # Method to Update a particular user, by accepting the user ID, attribute and value
    # It returns the updated user info
    def update(user_id, attribute, value)

        # Hash initialization to hold the info of the user to be updated
        user_info = Hash.new

        # Hash initialization to hold all updated users
        users_info = {}

        # if the attribute to be updated is ID abort operation with an error message
        if attribute == "id"
            abort "Unable to perform an update to a unique field: #{attribute}"
        end
        read().each do |line|

            # convert each line(user) to hash
            user = eval(line)
            
            # if the user id is the one to be updated, then perform update and add to the
            # users and user hash otherwise just add to the users hash only
            if user.keys[0] == user_id
                
                # If the key is available then update the value
                # else abort operation
                if user[user.keys[0]].key? attribute
                    user[user.keys[0]][attribute] = value
                else
                    abort "No column named #{attribute} present on the database"
                end

                # add the user to the users hash
                # and to the user hash
                users_info[user.keys[0]] = user[user.keys[0]]
                user_info = user[user.keys[0]]
            else
                users_info[user.keys[0]] = user[user.keys[0]]
            end
        end
        
        # write the users hash to file db.raw
        write_to_file(users_info)
        response(user_info,"User with ID #{user_id} Not Found")
    end

    # Method definition that accepts a user ID and deletes it from the database
    def destroy(user_id)
        user_info = Hash.new
        users_info = {}
        read().each do |line|

            # convert each line(user) to hash
            user = eval(line)
            # if the user id is the one to be deleted, then skip that loop and add the
            # remaining users to the users info hash
            if user.keys[0] == user_id
                user_info = {status: 0, message: "User ID: #{user_id} deleted successfully"}
                next
            else
                users_info[user.keys[0]] = user[user.keys[0]]
            end
        end

        # write the users info hash to file db.raw
        write_to_file(users_info)
        response(user_info,"User with ID #{user_id} Not Found")
    end

    # Method to write USERS HASH to file db.raw
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

    # Method to return a user hash or a message if empty
    def response(user_hash, message)
        if user_hash.empty?
            {status: 404, message: message}
        else
            user_hash
        end
    end
end

instance_user = User.new
p instance_user.create(["wisdom", "praise", 27, "Password", "email@mail.com"])
# p instance_user.get(1)
# p instance_user.all
# p instance_user.update(3, "age", 90)
# p instance_user.destroy(1)