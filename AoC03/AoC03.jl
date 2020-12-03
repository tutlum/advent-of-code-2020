function count_trees(forest,dx,dy)
    width = length(forest[1])
    trees = 0
    #print(res[1],"\n")
    if forest[1][1] == '#'
        trees=1
    end
    step=1
    while dy*step+1<=length(forest)
        #print(dy*step+1,"\n")
        x=((dx*step)%width)+1
        y=dy*step+1
        #print(res[y],"\n")
        #print(" "^(x-1),"^"," "^(width-x))
        if forest[y][x] == '#'
            trees+=1
            #print(" ",trees)
        end
        #print("\n")
        step+=1
    end
    return trees
end

forest = readlines("AoC03_data.txt")
print("solution part 1: ",count_trees(forest,3,1),"\n")

slopes=[(1,1),(3,1),(5,1),(7,1),(1,2)]
multiplied_trees=reduce(*,map(d -> count_trees(forest,d[1],d[2]),slopes))
print("solution part 2: ",multiplied_trees,"\n")
#map(x -> s[x[1]:x[2]], slopes)#test


