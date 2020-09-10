# function that accepts three string params and interpolates them then returns the interpolated results
def my_string_formatting(firstname, lastname, age)
    return "#{firstname} #{lastname} is #{age} years old"
end

puts my_string_formatting("Wisdom", "Praise", "26")