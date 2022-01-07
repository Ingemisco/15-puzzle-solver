require 'io/console'

def print_puzzle(permutation)
    (0...4).each do |y|
        (0...4).each do |x|
            if permutation[4*y+x] == 15
                print("   ")
            else
                print((permutation[4*y+x] + 1).to_s.rjust(3))
            end
        end
        puts
    end
    puts
end

def perform_rotation(permutation, rotation, pos_empty=permutation.index(15), print=false, wait=0)
    solution = [] unless print
    rotation.each do |r|
        solution << r unless print
        permutation[r], permutation[pos_empty] = permutation[pos_empty], permutation[r]
        STDOUT.clear_screen if print
        print_puzzle permutation if print
        
        pos_empty = r 
        sleep(wait) if wait > 0
        
    end
    return solution, permutation, pos_empty unless print
end

def rotate0(permutation)
    rotation = [14, 13, 12, 8, 9, 5, 4, 0, 1, 2, 3, 7, 6, 10, 11, 15]
    pos_empty = permutation.index(15)
    index_in_rotation = rotation.index(pos_empty)

    # put empty in last position
    solution, permutation, pos_empty = perform_rotation(permutation, rotation[index_in_rotation+1..-1], pos_empty)

    # rotate until 0 is in right position
    until permutation[0] == 0
        temp, permutation, pos_empty = perform_rotation(permutation, rotation, pos_empty)
        solution += temp
    end

    return solution, permutation
end

def rotate1(permutation)
    solution = []
    rotation1 = [14, 13, 9, 5, 1, 2, 3, 7, 11, 15]
    rotation2 = [14, 13, 12, 8, 4, 5, 1, 2, 6, 10, 11, 15]

    if rotation1.include?(permutation.index(1))
        rotation = rotation1
    else 
        rotation = rotation2
    end

    until permutation[1] == 1
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    return solution, permutation
end

def rotate2(permutation)
    solution = []
    rotation = [14, 13, 12, 8, 4, 5, 9, 10, 6, 2, 3, 7, 11, 15]
    
    until permutation[2] == 2
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end
    return solution, permutation
end

def rotate23(permutation)
    return [], permutation if permutation[3] == 3
    solution = []
    rotation = [14, 13, 12, 8, 4, 5, 9, 10, 6, 7, 11, 15]

    until permutation[7] == 3
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    additional_rotation = [11, 10, 6, 5, 1, 2, 6, 7, 3, 2, 6, 7, 3, 2, 1, 5, 9, 13, 14, 15] # this solves first row
    
    temp, permutation, _ = perform_rotation(permutation, additional_rotation)
    solution += temp
    
    return solution, permutation
end

def rotate4(permutation)
    solution = []
    rotation = [14, 13, 12, 8, 4, 5, 9, 10, 6, 7, 11, 15]

    until permutation[4] == 4
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end
    
    return solution, permutation
end

def rotate5(permutation)
    solution = []
    rotation1 = [14, 13, 12, 8, 9, 5, 6, 7, 11, 15]
    rotation2 = [14, 10, 9, 5, 6, 7, 11, 15]

    if rotation1.include?(permutation.index(5))
        rotation = rotation1
    else 
        rotation = rotation2
    end

    until permutation[5] == 5
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    return solution, permutation
end

def rotate6(permutation)
    solution = []
    rotation = [14, 13, 12, 8, 9, 10, 6, 7, 11, 15]
    
    until permutation[6] == 6
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end
    return solution, permutation
end

def rotate67(permutation)
    return [], permutation if permutation[7] == 7
    solution = []
    rotation = [14, 13, 12, 8, 9, 10, 11, 15]

    until permutation[11] == 7
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    additional_rotation = [14, 13, 9, 5, 6, 10, 11, 7, 6, 10, 11, 7, 6, 5, 9, 13, 14, 15] # this solves second row
    
    temp, permutation, _ = perform_rotation(permutation, additional_rotation)
    solution += temp
    
    return solution, permutation
end

def rotate812(permutation)
    solution = []
    rotation = [14, 13, 12, 8, 9, 10, 11, 15]

    until permutation[8] == 8
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    return solution, permutation if permutation[12] == 12

    rotation = [14, 13, 9, 10, 11, 15]

    until permutation[14] == 12
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    additional_rotation = [11, 10, 9, 8, 12, 13, 9, 8, 12, 13, 14, 10, 9, 8, 12, 13, 14, 15] 
    
    temp, permutation, _ = perform_rotation(permutation, additional_rotation)
    solution += temp
    
    return solution, permutation
end

def rotate913(permutation)
    solution = []
    rotation = [14, 13, 9, 10, 11, 15]

    until permutation[9] == 9
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    return solution, permutation if permutation[13] == 13

    rotation = [14, 10, 11, 15]

    until permutation[11] == 13
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end
    
    additional_rotation = [11, 10, 14, 13, 9, 10, 14, 15, 11, 10, 9, 13, 14, 15] 
    
    temp, permutation, _ = perform_rotation(permutation, additional_rotation)
    solution += temp
    
    return solution, permutation
end

def finish(permutation)
    solution = []
    rotation = [14, 10, 11, 15]
    until permutation[14] == 14
        temp, permutation, _ = perform_rotation(permutation, rotation)
        solution += temp
    end

    return solution, permutation
end

#test whether a sequence of moves is legal
def validate(solution)

    solution.each_cons(2) do |x, y|
        puts "not correct, after #{x} #{y} is not legal" unless (x-y).abs == 1 || (x-y).abs == 4 
        puts "#{x} is not a valid position" if x < 0 || x > 15
    end
end

def solve(permutation)
    # step 1: rotate 0 to correct position
    solution, permutation = rotate0(permutation)
    temp, permutation = rotate1(permutation)
    solution += temp
    temp, permutation = rotate2(permutation)
    solution += temp

    temp, permutation = rotate23(permutation)
    solution += temp

    temp, permutation = rotate4(permutation)
    solution += temp

    temp, permutation = rotate5(permutation)
    solution += temp

    temp, permutation = rotate6(permutation)
    solution += temp

    temp, permutation = rotate67(permutation)
    solution += temp
    temp, permutation = rotate812(permutation)
    solution += temp
    temp, permutation = rotate913(permutation)
    solution += temp

    temp, permutation = finish(permutation)
    solution += temp

    validate(solution)
    return solution
end

perm = [6, 14, 15, 1, 8, 2, 11, 5, 9, 12, 7, 10, 4, 0, 13, 3]

sol = solve(perm)

perm = [6, 14, 15, 1, 8, 2, 11, 5, 9, 12, 7, 10, 4, 0, 13, 3]
print_puzzle(perm)

perform_rotation(perm, sol, perm.index(15), true, 0.15)