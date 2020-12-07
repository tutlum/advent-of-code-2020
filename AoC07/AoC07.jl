function build_dict(file)#"AoC07_data_s.txt"
    data = readlines(file)
    instructions = [[strip(replace(replace(replace(b,r"bags*"=>""),"."=>""),"no other"=>"")) for b in split(a,"contain")] for a in data];
    dict = Dict()
    target=[]
    for instr in instructions
        td=Dict()
        for ent in split(instr[2],",")
            tmp=split(strip(ent)," ")
            key=strip(join(tmp[2:end]," "))
            if key!="" td[key]=parse(Int32,tmp[1]) end
        end
        dict[instr[1]]=td
    end
    return dict
end

# find a given bag in other bags and put the container bags into the list
function findrec(query, dict, list)
    for e in keys(dict)
        if query in keys(dict[e])
            #println(e, ": ", dict[e][query])
            if !(e in list)
                push!(list,e)
                findrec(e,dict,list)
            end
        end
    end
end


#counts the bags including given bag
function count_bags(query, dict)
    #println(dict[query])
    if length(keys(dict[query]))==0 return 1 end
    return 1+sum([(dict[query][k]*count_bags(k,dict)) for k in keys(dict[query])])
end

query="shiny gold"
dict = build_dict("AoC07_data.txt");

list=[]
findrec(query, dict, list)
println("number of ways: ", length(list))

# starting bag is counted thus -1
println("Inside the '",query,"' you need ",count_bags(query, dict)-1," bags.")


