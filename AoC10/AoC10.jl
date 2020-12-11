adapters = [0] # add start
append!(adapters,sort([parse(Int32,a) for a in readlines("AoC10_data.txt")]))
push!(adapters,adapters[end]+3); # add end

dict=Dict(1=>0,3=>0)
# calculate differences
diffs = [adapters[i]-adapters[i-1] for i in 2:length(adapters)]
for e in diffs
    dict[e]+=1
end
println("quantities: ", dict)

println("Solution is: ", dict[1]*dict[3])

# stupid recursive function ...
function countpossible(list, index, maxstep)
    #return 0
    anz=0
    for i in (index+1):min(index+maxstep,length(list)-1)
        if list[i]-list[index]<=maxstep
            if i==length(list)-1
                return anz+1
            end
            anz+=countpossible(list, i, maxstep)
        else
            return anz
        end
    end
    return anz
end

# count connected blocks of 1s with length >1
# because we know how many different combinations are threre for blocks longer then 1
# every shorter block only produces one possibility

function getblocks(diffs)
    ind=1
    blocks=[]
    while ind<length(diffs)
        if (diffs[ind]==1)
            count=0
            while diffs[ind]==1
                count+=1
                ind+=1
            end
            if count>1 push!(blocks,count) end
            continue
        end
        ind+=1
    end
    return blocks
end
# we only need until blocksize 4 ... so no further thoughts
multiply = Dict(2=>2,3=>4,4=>7,5=>11);

getblocks(diffs)
println("there are ", reduce(*,map(x->multiply[x],getblocks(diffs))), " possible adapter combinations")
