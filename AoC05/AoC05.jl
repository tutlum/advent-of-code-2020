function codetonumber(code)
    return [parse(Int32,replace(replace(code[1:7],"F"=>"0"),"B"=>"1"),base=2),parse(Int32,replace(replace(code[8:10],"L"=>"0"),"R"=>"1"),base=2)]
end
println(codetonumber("FBFBBFFRLR"))#passt
data=[codetonumber(a) for a in readlines("AoC05_data.txt")]
ids=[a[1]*8+a[2] for a in data];

println("highest id: ", maximum(ids))

for id in (minimum(ids)+1):(maximum(ids)-1)
    if !(id in ids) && ((id-1) in ids) && ((id+1) in ids)
        println("my seat: ", id)
        break
    end
end


