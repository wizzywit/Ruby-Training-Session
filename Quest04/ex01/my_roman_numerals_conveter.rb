=begin
    Function to convert a number to its equivalent roman numnerals,
    it accepts an integer number as params and returns a string roman numerals 
    equivalent.
=end
def roman_numerals(number)

    # check if number is an integer being passed
    unless number.instance_of? Integer
        print "Invalid Argument: Type must be Integer"
        return
    end

    # initialized a hash called map, to map roman to integer
    map = {
        "I" => 1,
        "IV" => 4,
        "V" => 5,
        "IX" => 9,
        "X" => 10,
        "XL" => 40,
        "L" => 50,
        "XC" => 90,
        "C" => 100,
        "CD" => 400,
        "D" => 500,
        "CM" => 900,
        "M" => 1000
    }

    # array to store the keys of the map
    keys = map.keys

    # Initializing the roman numeral
    roman_numeral = "";
    
    i = 12
    while number > 0
        # assign the value after dividing by the current value in the map hash
        # determined by the variable i(loop counter equivalent to the size of the hash)
        div = number / map[keys[i]]

        # assign the remainder if any to variable number
        number = number.modulo(map[keys[i]])

        # while the value stored in div is greater than
        while div > 0
            roman_numeral += keys[i]
            div -= 1
        end
        i -= 1
    end
    roman_numeral
end

# Output the roman numeral equivalent of an integer
print roman_numerals(4998)
