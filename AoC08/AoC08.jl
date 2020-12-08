# toggle the "correct"-th jmp/nop command
function runcode(commands, correct=0)
    acc=0
    visited=Dict{Int32,Bool}()
    i=1
    infinite=false
    jmpnop_n=0
    while (i<=length(commands))
        if haskey(visited, i)
            infinite=true
            break
        end
        visited[i]=true
        comm=commands[i][1]
        # correction
        if (correct!=0 && (comm=="jmp" || comm=="nop"))
            jmpnop_n+=1
            if correct==jmpnop_n
                #println(jmpnop_n, " ", i, " ", commands[i])
                if (comm=="jmp") comm="nop" else comm="jmp" end
            end
        end
        #println(commands[i])
        if (comm=="acc")
            acc+=parse(Int32,commands[i][2])
            i+=1
        elseif (comm=="jmp")
            i+=parse(Int32,commands[i][2])
        elseif (comm=="nop")
            i+=1
        end
    end
    return [infinite,acc]
end

function num_of_jmp(commands)
    n=0
    for comm in commands
        if comm[1]=="jmp" || comm[1]=="nop"
            n+=1
        end
    end
    return n
end

commands = [split(a, " ") for a in readlines("AoC08_data.txt")]
jumps=num_of_jmp(commands)
result=runcode(commands)
println("uncorrected solution: acc=", result[2])
infinite=true
ch_n=0
while infinite==1
    if ch_n>jumps break end
    result=runcode(commands,ch_n)
    infinite=result[1]
    if infinite==0
        println("change ", ch_n, "th command")
        break
    end
    ch_n+=1
end
println("infinite: ", result[1], ", acc=",result[2])




