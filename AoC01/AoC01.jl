res = readlines("AoC01_data.txt")
numbers = [parse(Int32,a) for a in res if a!=""];

println(unique([a*b for a in numbers for b in numbers if a+b==2020]))

for i in 1:length(numbers)
    for j in i:length(numbers)
        if (numbers[i]+numbers[j]==2020)
            println(numbers[i]*numbers[j])
            break
        end
    end
end

println(unique([a*b*c for a in numbers for b in numbers for c in numbers if a+b+c==2020]))

for i in 1:length(numbers)
    for j in i:length(numbers)
        for k in max(i,j):length(numbers)
            if (numbers[i]+numbers[j]+numbers[k]==2020)
                println(numbers[i]*numbers[j]*numbers[k])
                break
            end
        end
    end
end


