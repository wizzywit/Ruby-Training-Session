=begin
    A program called my_cat to do the same thing as cat command line utility
=end
def my_cat argv
    file_data = ""

    # check if argv is empty and print what is piped to the command
    if argv.size == 0
        return STDIN.read
    end
    
    argv.each do |filename|
        if FileTest.exist? (File.expand_path(filename))
            file = File.read(File.expand_path(filename))
            file_data += file
            file_data += "\n"
        else
            file_data += "my cat: #{filename}: No such file or directory \n"
        end
    end

    return file_data
end

puts my_cat ARGV
