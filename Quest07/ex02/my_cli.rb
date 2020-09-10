# Readline module import
require 'readline'

# Store the state of the terminal
stty_save = 'stty -g'.chomp

# Iteration on every readline until enter key pressed
begin
    while line = Readline.readline("MyCli> ", true)
        array_input = line.split(" ")
        if array_input[0].downcase == "exit"
            print "Goodbye!"
            exit
        else
            p array_input
        end
    end
rescue Interrupt => exception
    system('stty', stty_save)
    exit
end
