function readdata(file)
    room = readlines(file)
    roomA = Array{Int8,2}(undef, length(room), length(room[1]))
    roomB = Array{Int8,2}(undef, length(room), length(room[1]))
    for (i,row) in enumerate(room)
        for (j,p) in enumerate(row)
            if (p=='.')
                roomA[i,j]=2
                roomB[i,j]=2 end
            if (p=='#')
                roomA[i,j]=1
                roomB[i,j]=1 end
            if (p=='L')
                roomA[i,j]=0
                roomB[i,j]=0 end
        end
    end
    return roomA, roomB
end

# counts the occupied seats in the room and optionally prints the layout
function countroom(rA,pri=false)
    s=size(rA)
    occ=0
    for i in 1:s[1]
        for j in 1:s[2]
            if pri
                if rA[i,j]==2 print('.') end
                if rA[i,j]==0 print('L') end
            end
            if rA[i,j]==1
                if pri print('#') end
                occ+=1
            end
        end
        if pri print('\n') end
    end
    if pri print('\n') end
    return occ
end

# returns the occupied seats of arr in the direct surrounding of (ci,cj)
function enforceRule(arr, ci, cj)
    s=size(arr)
    count = 0
    for i in (ci-1):(ci+1)
        for j in (cj-1):(cj+1)
            if 1<=i<=s[1] && 1<=j<=s[2] && !(i==ci && j==cj) && arr[i,j]==1 count+=1 end
        end
    end
    return count
end

# returns the occupied seats in direct sight (and cannot see through empty ones)
function enforceRuleFar(arr, ci, cj)
    s=size(arr)
    count = 0
    for i in (-1):(1)
        for j in (-1):(1)
            if !(i==0 && j==0)
                n=1
                while (1<=ci+i*n<=s[1] && 1<=cj+j*n<=s[2])
                    if arr[ci+i*n,cj+j*n]==1
                        count+=1
                        break
                    elseif arr[ci+i*n,cj+j*n]==0
                        break
                    end
                    n+=1
                end
            end
        end
    end
    return count
end

# updates array rB with the rules given by maxi,mini,f and returns if something has changed
function update(rA,rB,maxi=4, mini=0,f=enforceRule)
    update = 0
    s=size(rA)
    for i in 1:s[1]
        for j in 1:s[2]
            if rA[i,j]==0
                if f(rA, i, j)==mini
                    rB[i,j]=1
                    update = 1
                else
                    rB[i,j]=rA[i,j]
                end
            elseif rA[i,j]==1
                if f(rA, i, j)>=maxi
                    rB[i,j]=0
                    update = 1
                else
                    rB[i,j]=rA[i,j]
                end
            end
        end
    end
    return update
end

function solution(data="AoC11_data.txt",maxi=4,mini=0,f=enforceRule)
    roomA, roomB = readdata(data)
    countroom(roomB,false)
    println()
    while update(roomA,roomB,maxi,mini,f)==1
        #printroom(roomB)
        (roomA,roomB)=(roomB,roomA)
    end
    return countroom(roomB)
end

println("solution for part 1 is: ", solution(), " occupied seats")

println("solution for part 2 is: ", solution("AoC11_data.txt",5,0,enforceRuleFar), " occupied seats")


