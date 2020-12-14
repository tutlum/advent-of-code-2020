#       N(0)
#        |
# W(270)---E(90)
#        |
#      S(180)
# ship=Dict('N'=>0,'E'=>0,'D'=>0)
function calc_pos(ship,instructions)
    for (c,v) in instructions
        if c=='N' ship['N']+=v
        elseif c=='E' ship['E']+=v
        elseif c=='S' ship['N']-=v
        elseif c=='W' ship['E']-=v

        elseif c=='L' ship['D']=(ship['D']-v+360)%360
        elseif c=='R' ship['D']=(ship['D']+v)%360

        elseif c=='F'
            if ship['D']==0 ship['N']+=v
            elseif ship['D']==90 ship['E']+=v
            elseif ship['D']==180 ship['N']-=v
            elseif ship['D']==270 ship['E']-=v
            end
        end
    end
end
# ship=Dict('N'=>0,'E'=>0), waypoint=Dict('N'=>0,'E'=>0)
function folow_way(ship,waypoint,instructions)
    for (c,v) in instructions
        if c=='N' waypoint['N']+=v
        elseif c=='E' waypoint['E']+=v
        elseif c=='S' waypoint['N']-=v
        elseif c=='W' waypoint['E']-=v

        elseif c=='L' || c=='R'
            v2=v
            if c=='R' v2=360-v end
            if v2==90 (waypoint['E'],waypoint['N'])=(-waypoint['N'],waypoint['E'])
            elseif v2==180 (waypoint['E'],waypoint['N'])=(-waypoint['E'],-waypoint['N'])
            elseif v2==270 (waypoint['E'],waypoint['N'])=(waypoint['N'],-waypoint['E'])
            end

        elseif c=='F'
            ship['E']+=v*waypoint['E']
            ship['N']+=v*waypoint['N']
        end
    end
end

data = readlines("AoC12_data.txt")
instructions=[(a[1],parse(Int32,a[2:end])) for a in data];
dict = Dict('N'=>0,'E'=>0,'D'=>90)
calc_pos(dict,instructions)
println("solution part 1: ",dict, " hash: ",abs(dict['N'])+abs(dict['E']))

waypoint = Dict('N'=>1,'E'=>10)
ship = Dict('N'=>0,'E'=>0)
folow_way(ship,waypoint,instructions)
println("solution part 2: ",ship, " hash: ",abs(ship['N'])+abs(ship['E']))


