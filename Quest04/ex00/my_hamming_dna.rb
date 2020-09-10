=begin
    function definition to calculate the hamming distance between two homologous DNA
    strands, which accepts two dna strands and returns the hamming distance
=end
def hamming_dna (dna_1, dna_2)

    # hamming distance initialization
    hamming_distance = 0;
    
    # converting both strands to array
    dna_1_array = dna_1.split('')
    dna_2_array = dna_2.split('')

    # looping and comparing both strands and update the hamming_distance
    dna_1_array.each_with_index do |dna_strand, index|
        if dna_strand != dna_2_array[index]
            hamming_distance +=1
        end
    end

    # return the hamming distance
    hamming_distance
end

# output the hamming distances
print hamming_dna("GGACGGATTCTG","AGGACGGATTCT")