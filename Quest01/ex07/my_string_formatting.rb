# function that accepts three string params and interpolates them then returns the interpolated results
def my_string_formatting(firstname, lastname, age)
    return "Hello, my name is #{firstname} #{lastname}, I'm #{age}.\n"
end

puts my_string_formatting("Wisdom", "Praise", 26)