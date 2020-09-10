def my_christmas_tree argv
    # If argument passed is greater than one which is the allowed number
    # of argument then output and error message and exit from function
    if argv.size > 1
        print "Only one argument is allowed"
        return
    end

    # If No argument is given output an error message and exit from function
    if argv.size < 1
        print "Missing Argument: <argument> of type integer missing"
        return
    end

    # Handle Exception on Convertion of the string argument to its equivalent integer
    # Throw an exception if unable to convert
    begin
        argv[0] = Integer argv[0]
    rescue => exception
        print "Invalid argument: Allowed arguments must be of type Int (Whole Number)"
        return        
    end
    
    # Initialize loop counter to zero
    i = 0

    # Initialize the up step variable moving up the tree, to determine the space and number of asteriks
    # to be displayed on the start of every traingle
    up_step = 2

    # Initialize the traingle step (Increases from 4 to 5 to 6 and so on)
    triangle_size = 4

    # Initialize the total space displayed on the start of the program, which is
    # 4 times the argument passed, minus 1
    total_space = ((8*argv[0]-2)/2)

    # Initialize and assign the number of the asterik to be equal to one(for the first case), which is the
    # begining of every program
    asteriks_count = 1

    # Loop definition to display every triangle
    while i< argv[0]

        # loop from 1 to the traingle size
        1.upto(triangle_size) do |x|

            # on each loop display the total space and number of asteriks
            print (" "*total_space)
            puts ("*"*asteriks_count)

            # Decrement the total space by one for the next iteration
            total_space -=1

            # Increment the number of asteriks count by two (which is the pattern of increment on every traingle)
            asteriks_count +=2
        end

        # Incrementing the looping counter by one
        i += 1

        # Incrementing the total space by the up step times one
        # so depending on what step it is in the while loop the total space would be same space as two steps up
        total_space += (1*up_step)

        # Decrementing the asteriks count by the up step times two
        asteriks_count -= ((2*up_step))

        # Incrementing the up step by one on every iteration only if after incrementing the loop counter, it is even
        # unless i.odd?
        #     up_step +=1
        # end

        if i > 1
            up_step +=1
        end
        

        # Incrementing the traingle size by one
        triangle_size +=1
    end

    # Initializing and assigning the leg space of the tree
    # The leg space is depending on the argument passed. A bit of Maths here
    leg_space = ((8*argv[0]-2)/2) - ((argv[0]-1)/2)

    # Looping to the argument number of times and printing the calculated spaces and
    # number of asteriks (which is times the argument passed)
    1.upto(argv[0]) do |x|
        print(" "*leg_space)
        puts ("|"*argv[0])
    end
end

# function call to display the christmas tree
my_christmas_tree ARGV


