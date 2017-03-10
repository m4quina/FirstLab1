def read_data(file_name)
    if  File.exist?(file_name)
        File.open(file_name)
    else
        puts "Такого файла не существует"
        return nil
    end
end

def convert_to_matrix(number_strings)
    number_strings.map do |string|
        string.strip.split(/\s+/).map do |num_string|  
            num_string.to_i
        end
    end
end

def print_matrix(matrix)
     n_spaces = find_max(matrix)
     matrix.each do |array|
         array.each_index do |j|
                $stdout.printf("%-*d", n_spaces, array[j])
         end
         puts("\n")
     end
end

def is_matrix(numbers)
    numbers.each do |array1|
        numbers.each do |array2|
            if array1.size != array2.size
                puts "This is not a matrix! Try again"
                return nil
            end
        end
    end 
end

def process_file(file_name)
    puts "\n************\nProcessing #{file_name}"
    number_strings = read_data(file_name)
    return unless number_strings
    numbers = convert_to_matrix(number_strings)
    if is_matrix(numbers) != nil
        puts "\nOriginal matrix\n---------------"
        print_matrix(numbers)
        puts "\nModified matrix \n---------------"
        numbers = replace_columns_by_characteristic(numbers)
        print_matrix(numbers)
    end
end

def replace_columns_by_characteristic (matrix)
    matrix = matrix.transpose
    sum = []
    matrix.each do |array|
        sum.push(s_array(array))
    end
    swap = true
    size = sum.length - 1 
    while swap
        swap = false
        for i in 0...size
            if sum[i] > sum[i+1]
                swap |= sum[i] > sum[i+1]
                sum[i], sum[i+1] = sum[i+1], sum[i]
                matrix[i], matrix[i+1] = matrix[i+1], matrix[i]
            end
        end
        size -= 1
    end
    matrix = matrix.transpose
end

def s_array(array)
    sum = 0 
    array.each do |i|
        if i < 0
            if i%2 == 1
                sum+=i.abs
            end
        end
    end
    sum
end

def find_max(matrix)
    max = 0 
    matrix.each do |array|
        array.each_index do |j|
            if array[j].abs > max
                    max = array[j].abs
            end
        end
    end
    n_spaces = 3
    while max >= 10
        max/=10
        n_spaces+=1
    end
    n_spaces
end

def main
    if ARGV.empty?
        puts "Please write here a name of some file with matrix inside"
    end
    ARGV.each do |file_name|
        process_file(file_name)
    end
end

main