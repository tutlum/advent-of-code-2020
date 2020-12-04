# functions and data to validate
# fields
needed=["byr","iyr","eyr","hgt","hcl","ecl","pid"]
optional=["cid"]

# fieldvalidation
function height(expr)
    unit=expr[length(expr)-1:length(expr)]
    if unit=="cm"
        return 150<=parse(Int32,expr[1:length(expr)-2])<=193
    elseif unit=="in"
        return 59<=parse(Int32,expr[1:length(expr)-2])<=76
    else
        return false
    end
end

# validationfunctions
validation = Dict("byr"=>x->1920<=parse(Int32,x)<=2002,
    "iyr"=>x->2010<=parse(Int32,x)<=2020,
"eyr"=>x->2020<=parse(Int32,x)<=2030,
"hgt"=>x->height(x),
"hcl"=>x->match(r"^#([0-9]|[a-f]){6}$",x)!=nothing,
"ecl"=>x->x in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"],
"pid"=>x->match(r"^[0-9]{9}$",x)!=nothing);


# checking function
# with checkcont=ture the content of the fields is checkt
function check(needed, passport, checkcont)
    for key in needed
        found=false
        for ppf in passport
            if key==ppf[1]
                try
                    if (checkcont && !validation[key](ppf[2]))
                        #print(key, " ", ppf[2], "\n")
                        return false
                    end
                    found=true
                catch e
                    #print(e)
                    return false
                end
            end
        end
        if !found return false end
        #if !(key in [passport[i][1] for i in 1:length(passport)])
        #    return false
        #end
    end
    return true
end
    

# read data
function readppd(file)
    batch = open(file) do file
        read(file, String)
    end
    return [[split(b,":",) for b in split(a,[' ','\n'])] for a in split(batch,"\n\n")]
end

# solution part 1
println("part2:",sum([check(needed,pp,false) for pp in readppd("AoC04_data.txt")]))

# checking the tests
println(sum([check(needed,pp,true) for pp in readppd("AoC04_data_s_val.txt")]))
println(sum([check(needed,pp,true) for pp in readppd("AoC04_data_s_inval.txt")]))

# solution part2
println("part2:",sum([check(needed,pp,true) for pp in readppd("AoC04_data.txt")]))


