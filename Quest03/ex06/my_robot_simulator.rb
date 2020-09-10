=begin 
    function that accepts instruction as string and calculates the locatiion/postion of
    robot in space in reference to an initial position. and returns the new position after executing the instructions 
=end

def run_robot(instructions)

    # converts the string instructions to an array of characters
    instructions = instructions.split('')

    #initial position of the robot
    initial_position = {x: 0, y: 0, bearing: :north}
    # print instructions

    directions = [:north, :east, :south, :west]
    # loop on every instructions in the array
    instructions.each do |instruction| 
        instruction == 'L' ? directions.rotate!(-1) : directions
        instruction == 'R' ? directions.rotate!(1) : directions
        if instruction == 'A'
            directions[0] == :west ? initial_position[:x]-=1: initial_position[:x]
            directions[0] == :east ? initial_position[:x]+=1: initial_position[:x]
            directions[0] == :south ? initial_position[:y]+=1: initial_position[:y]
            directions[0] == :north ? initial_position[:y]-=1: initial_position[:y]
        end
    end
    initial_position[:bearing] = directions[0]
    return initial_position
end


=begin
 Display the output position of the robot based on the instruction passed
 as an argument to the function
=end
puts run_robot "RAALALL"
puts run_robot "AAAA"
puts run_robot "RAARA"
puts run_robot ""



