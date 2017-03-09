def read_data(file_name)
    if  File.exist?(file_name)
        File.open(file_name)
    else
        puts "Такого файла не существует"
        return nil
    end
end

def convert_to_array(number_strings)
    number_strings.map do |string|
        string.strip.split(/\s+/).map do |num_string|  
            num_string.to_i
        end
    end
end

def move_to_diagonal(numbers)
    numbers.each_with_index do |array, index|
        max = array.max
        max_index = array.index(max)
        array[max_index] = array[index]
        array[index] =  max
    end
end

def print_matrix(matrix)
     #matrix.each {|line| puts line.join(" ")}
     m = find_max(matrix)
     matrix.each_index do |i|
         matrix.each_index do |j|
             $stdout.printf("%*d", m, matrix[i][j])
         end
         puts("\n")
     end
end

def process_file(file_name)
    puts "Processing #{file_name}"
    number_strings = read_data(file_name)
    return unless number_strings
    numbers = convert_to_array(number_strings)
    puts "\nOriginal matrix\n---"
    print_matrix numbers
    #puts "Modified matrix"
    #print_matrix move_to_diagonal(numbers)
    puts "\nModified matrix \n---"
    modified_matrix(numbers)
    find_max (numbers)
end

def column_sum(matrix)
    sum = []
        matrix.each_index do |i|
            sum[i]=0
            matrix.each_index do |j|
                if matrix[j][i] < 0
                    if matrix[j][i] %2 == 1 
                        sum[i]=matrix[j][i].abs+sum[i]
                    end
                end
            end
        end
    sum
end

def modified_matrix(matrix)
    sum = column_sum(matrix)
    swap = true
    size = sum.length - 1
    while swap
        swap = false
        for i in 0...size
        swap |= sum[i] > sum[i + 1]
            if sum[i] > sum[i + 1]
                sum[i], sum[i+1] = sum[i + 1], sum[i]
                matrix.each_index do |k|
                    matrix[k][i], matrix[k][i+1] = matrix[k][i+1], matrix[k][i]
                end
            end
        end
        size -= 1
    end
    print_matrix(matrix)
end
def find_max(matrix)
    m = []
    matrix.each_with_index do |array, index|
        max = array.max {|a,b| a.abs<=>b.abs}
        m.push(max)
    end
    max = m.max {|a,b| a.abs<=>b.abs} 
    count = 2
    if max < 0
        count = 3
    end
    max = max.abs
    while max > 10
        max/=10
        count+=1
    end
    count
end
def main
    process_file("data.txt")
    $stdout.printf("",)
end

main