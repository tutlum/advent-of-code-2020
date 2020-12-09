signal = [parse(Int64, s) for s in readlines("AoC09_data.txt") if s!=""];

function find_mistake(signal, preamblelength)
    for (i,s) in enumerate(signal)
        watchlist=signal[max(1,i-preamblelength):i-1]
        if i>preamblelength && !(s in [a+b for a in watchlist for b in watchlist])
            #println([a for a in signal[max(1,i-preamblelength):i-1]])
            return (s,i)
        end
    end
end

function find_weakness(signal, target, place)
    for i in 1:place
        for j in (i+1):place
            if target==sum(signal[i:j])
                return maximum(signal[i:j])+minimum(signal[i:j])
            end
        end
    end
end
                

mistake=find_mistake(signal, 25)
weakness = find_weakness(signal,mistake...)

println("the first false number is ", mistake[1], " at position ", mistake[2])

println("the encryptionweakness is  ", weakness)




