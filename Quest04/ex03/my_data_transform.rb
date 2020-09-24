require 'time'
require 'json'
##
##
## QWASAR.IO -- my_csv_parser
##
## This method converts a csv type string into an array of arrays
##
## @param {String} csv_string
## @param {String} separator default= ','
##
## @return {String[][]}
##

def my_csv_parser (csv_string, separator = ',')
    output_array = []
    csv_string.each_line do |line|
        array = line.split(separator)
        array.map! do |elem| 
            elem.delete("\n")
        end
        output_array << array
    end
    output_array
end

##
##
## QWASAR.IO -- age_range
## 
## This method returns the age range from an input age passed in
##
## @param {Integer} age
##
## @return {String}
##
def age_range(age)
    return "1->20" if age >= 1 and age <= 20
    return "21->40" if age >= 21 and age <= 40
    return "41->65" if age >= 41 and age <= 65
    return "66->99" if age >= 66 and age <= 99
end

##
##
## QWASAR.IO -- email_provider
##
## This method determines the email provider 
## of every email passed into it
##
## @param {String} email
##
## @return {String}
##
def email_provider(email)
    email_provider = email.split('@')
    email_provider[1]
end

##
##
## QWASAR.IO -- date_period
##
## This method converts a time format string into periods of the day
## E.g 6:00am to morning and so on
##
## @param {String} time
##
## @return {String}
##
def date_period(time)
    time = time.split(' ')
    time = Time.parse(time[1])
    return "morning" if time >= Time.parse('06:00am') and time <= Time.parse('11:59am')
    return "afternoon" if time >= Time.parse('12:00PM') and time <= Time.parse('5:59pm')
    return "evening" if time >= Time.parse('6:00pm') and time <= Time.parse('11:59pm')
    return "invalid format"
end

##
##
## QWASAR.IO -- my_data_transform
##
## This method transforms a csv field data and returns an array of strings
## it transforms the Email, Age and Order At field to somewhat 'email provider',
## '1->20/21->40/41->65/66->99' and 'morning/afternoon/evening' respectively
##
## @param {String} csv_content
##
## @return {String[]}
##
def my_data_transform(csv_content)

    # store the csv content as an array of arrays
    array = my_csv_parser(csv_content)

    # Initialize an empty array to hold the output array
    new_array = []

    # Initialize an empty hash for processing
    index = Hash.new

    # Looping through every array element and perform transformation on a particular sets of fields
    array.each_with_index do |row, indx|

        # if the first row(representing the columns) loop through every
        # element assign that hash(element) to the index value for a specified sets of column elements
        # then join each elements into a single string and push the new_array
        #
        # else if its on the preceeding rows, then retrieve the values of every 
        # index(being stored on the first condition) and transform them, also perform a join on 
        # every element on that row to a single string and push to the new_array
        if indx == 0
            row.each_with_index do |v,i|
                if v == "Email" or v == "Age" or v == "Order At"
                    index[v] = i
                end
            end
            new_array << row.join(',')
        else
            email = row[index["Email"]]
            age = row[index["Age"]].to_i
            order_time = row[index["Order At"]]
            row[index["Email"]] = email_provider(email)
            row[index["Age"]] = age_range(age)
            row[index["Order At"]] = date_period(order_time)
            new_array << row.join(',')
        end
    end
    new_array
end

##
##
## QWASAR.IO -- my_data_process
##
## This method accepts a string array and groups every column, returning an hash
##
## @param {String[]} string
##
## @return {Hash}
##
def my_data_process(string)

    # instantiate an empty hash
    hash = Hash.new

    # split every element into and array inside the string array
    string.map! do |elem|
        elem.split(',')
    end

    # assigns the first element(array) to column
    column = string[0]

    # assign the remaining to rows
    rows = string[1..-1]

    # looping through every element in the column create a key in the hash
    # and assign a new hash to that key (having grouped elements) 
    column.each_with_index do |elem,idx|

        # Initialize an empty array for a particular column
        column_array = []

        # loop through every row in rows and push the element of the same index as
        # the column current element
        rows.each do |row|
            column_array << row[idx]
        end

        # group the elements in the column array and assign to a new hash
        new_hash = column_array.group_by{ |x| x}

        # adjust the grouped hash by returning the size of the groups instead of the actual elements
        new_hash = new_hash.map {|k,v| [k, v.size()] }.to_h      

        # assign the final hash value to the current key/element
        hash[elem] = new_hash
    end

    # remove unwanted keys from the hash and return the update hash in json format
    result = except(hash, ["FirstName", "UserName", "LastName", "Coffee Quantity"])
    result.to_json
end

##
## 
## QWASAR.IO -- except
##
## This Method loops through every key(passed) as an array and performs a hash delete
##
## @param {Hash} hash
## @param {String[]} keys
##
## @return {Hash} Hash
##
def except(hash, keys)
    keys.each { |key| hash.delete(key) }
    hash
end

# p date_period('2020-03-06 19:37:56')
# p age_range(57)
sample = "Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At\nMale,Carl,Wilderman,carl,wilderman_carl@yahoo.com,29,Seattle,Safari iPhone,2,2020-03-06 16:37:56\nMale,Marvin,Lind,marvin,marvin_lind@hotmail.com,77,Detroit,Chrome Android,2,2020-03-02 13:55:51\nFemale,Shanelle,Marquardt,shanelle,marquardt.shanelle@hotmail.com,21,Las Vegas,Chrome,1,2020-03-05 17:53:05\nFemale,Lavonne,Romaguera,lavonne,romaguera.lavonne@yahoo.com,81,Seattle,Chrome,2,2020-03-04 10:33:53\nMale,Derick,McLaughlin,derick,mclaughlin.derick@hotmail.com,47,Chicago,Chrome Android,1,2020-03-05 15:19:48\n"
output = my_data_transform(sample)
print my_data_process(output)