tmp = readlines("AoC02_data.txt")
data=[split(a," ") for a in tmp]
password=[a[3] for a in data]
criteria=[a[2][1] for a in data]
minmax=[[parse(Int32,b) for b in split(a[1],"-")] for a in data];

count=0
for (i,pw) in enumerate(password)
    tmp = split(pw,criteria[i])
    if minmax[i][1] <= length(tmp)-1 <=minmax[i][2]
        count+=1
        #print(minmax[i]," ",criteria[i]," ",pw,"\n")
    end
end
print("solution part 1: ", count, " of ", length(password))

count=0
for (i,pw) in enumerate(password)
    if (pw[minmax[i][1]] == criteria[i])
        if (pw[minmax[i][2]] != criteria[i])
            count+=1
        end
    elseif (pw[minmax[i][2]] == criteria[i])
        count+=1
    end    
end
print("solution part 1: ", count, " of ", length(password))


