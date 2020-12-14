#using InfiniteArrays, LinearAlgebra
data = readlines("AoC12_data_s.txt")
mytime=parse(Int64,data[1])
#data[2]="1789,37,47,1889"
ids=[parse(Int64,x) for x in split(replace(data[2],'x'=>'0'),",")];

valid_sorted=sort([[id,id-mytime%id] for id in ids if id!=0],lt=(a,b)->a[2]<b[2]);

println("the multiplied result of ",valid_sorted[1], " is: ",valid_sorted[1][1]*valid_sorted[1][2])

prod([i for i in ids if i!=0])

function isdiv(poses,n)
    for i in 1:(length(poses)-1)
        r=(poses[1][2]*n+(poses[i+1][1]-poses[1][1]))%poses[i+1][2]
        #if r!=0 return [poses[i+1][2]-r,r÷(poses[i+1][1]-poses[1][1]+1),poses[i+1][2],(poses[i+1][1]-poses[1][1]+1)] end
        if r!=0 return [poses[i+1][2]-r,abs(r÷(poses[i+1][1]-poses[1][1]))] end
    end
    return [0]
    #return sum([(poses[1][2]*n+(poses[i+1][1]-poses[1][1]))%poses[i+1][2] for i in 1:(length(poses)-1)])
end
# there has to be a better way ...
function validsfor(id_list,min,max,pos1,poses)
    #[[n,(ids[1]*n+1)÷ids[2],ids[1]*n,ids[1]*n+1] for n in 1:1000 if (ids[1]*n+1)%ids[2]==0]
    n=min
    while n<=max
        r=isdiv(poses,n)
        
#        println(r," ",n)
        if r[1]==0
            return [poses[1][2]*n-(poses[1][1]-1),n]
            #n+=1
        elseif r[2]<=1 n+=1
        else n+=r[2]+1
        end
        #n+=1
    end
    return -1
    #return [poses[1][2]*n-(poses[1][1]-1) for n in valid_bases if isdiv(poses,n)==0][1]
end
#sum([(id_list[pos1]*n+(pos[i+1]-pos1))%id_list[pos[i+1]] for i in 2:(length(l)-1)]

dict=Dict()
l=[]
for (i,id) in enumerate(ids)
    if id!=0
        dict[i]=id
        push!(l,[i,id])
    end
end
l=sort(l,rev=true,lt=(a,b)->a[2]<b[2])
println(l)
start=100000000000000/l[1][2]
s2=1000000000
println(start," ",s2)
valids=validsfor(ids,1,s2,l[1][1],l)
#valids=validsfor(ids,start:(2*start),l[1][1],l)
#println(length(l))
#println([((valids[1]+(l[i][1]-1))/l[i][2]) for i in 1:length(l)])
println(valids)

println((3*11)%18)
println(41*3%31)


