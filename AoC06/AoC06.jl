# read data
function readdata(file)
    batch = open(file) do file
        read(file, String)
    end
    return split(batch,"\n\n")
end

# solution to part 1 (anyone):
println("part1: ",
sum([length(Set(replace(a,"\n"=>""))) for a in readdata("AoC06_data.txt")]))

# solution to part 1 (anyone):
println("part2: ",
sum([length(intersect([Set(b) for b in split(strip(a),"\n")]...)) for a in readdata("AoC06_data.txt")]))


