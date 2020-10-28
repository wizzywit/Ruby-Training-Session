require 'sqlite3'

class User

    def initialize
        query = File.read("db.sql")
        begin
            @@db = SQLite3::Database.open 'my_user_app.db'
            @@db.results_as_hash = true
            @@db.query(query)
        rescue SQLite3::Exception => e 
            p "Error Connecting to the database"
            p e
        end
    end

    def create(user_info)
        if user_info.is_a?(Array) 
            firstname, lastname, age, password, email = user_info
            query = "insert into users (firstname,lastname,age,password,email) values (?, ?, ?, ?,?)"
            begin
                @@db.execute(query, firstname, lastname, age, password, email)
                return @@db.last_insert_row_id
            rescue SQLite3::Exception => e 
                p e
            end
        else
            return nil
        end 
    end

    def get(user_id)
        begin
            record = @@db.execute("select * from users where id = ?", user_id)
        rescue => exception
            p exception
        end
        return record
    end

    def all
        begin
            records = @@db.execute("select firstname, lastname, age, email from users")
        rescue => exception
            p exception
        end

        return records
    end

    def all_with_password
        begin
            records = @@db.execute("select * from users")
        rescue => exception
            p exception
        end

        return records
    end

    def destroy(user_id)
        begin
            @@db.execute("delete from users where id = ?", user_id)
        rescue => exception
            p exception
        end
        return "Successfully removed user from database"
    end

    def update(user_id, attribute, value)
        begin
            @@db.execute("update users set #{attribute}=? where id = ?", value, user_id)
            updated_record = @@db.execute("select * from users where id = ?", user_id)
        rescue => exception
            p exception
        end
        return updated_record
    end
    

end

# u  = User.new

# # p u.create(['james', 'maddison', 22, 'password', 'james@example.com'])
# p u.all
# # p u.destroy(5)
# # p u.update(1, 'password', 'passkey')