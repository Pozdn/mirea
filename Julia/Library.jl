function reverse(side)

    if side == Nord
        side = Sud
    elseif side == Sud
        side = Nord
    elseif side == West
        side = Ost
    else
        side = West
    end

end

function moving(r, side, counter)

    for i in 1:counter
        move!(r, side)
    end

end
function moving(r, side)

    local a = 0

    while !isborder(r, side)
        move!(r, side)
        a += 1
    end

    return a

end

function moving_marker(r, side)
    while ismarker(r) & !isborder(r, side)
        move!(r,side)
    end
end

function moving_paint(r, side, counter)
    local i = 1
    while !isborder(r, side) && (counter >= i)
        putmarker!(r)
        move!(r, side)
        i += 1
    end
    putmarker!(r)
end
function moving_paint(r, side)
    local a = 0
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
        a += 1
    end
    putmarker!(r)
    return a
end


function try_move!(r, side)
    if isborder(r, side) false
    else 
        move!(r, side)
        true 
    end
end
function moving!(r, side::HorizonSide, counter::Int)
    for _ in 1:counter
        move!(r, side)
    end
end
function moving!(r, side::HorizonSide)
    local a = 0
    while !isborder(r, side)
        move!(r, side)
        a += 1
    end
    return a
end
function moving!(stop_condition::Function, robot, side, max_counter)
    n = 0
    while n < max_counter && !stop_condition() && try_move!(robot, side) # - в этом логическом выражении порядок аргументов важен!
        n += 1
    end  
    return n 
end
function moving_marker(r, side)
    while ismarker(r) && !isborder(r, side)
        move!(r,side)
    end
end
function moving_with_trace!(r, side, counter)
    local i = 1
    while !isborder(r, side) && (counter >= i)
        putmarker!(r)
        move!(r, side)
        i += 1
    end
    putmarker!(r)
end
function moving_with_trace!(r, side)
    local a = 0
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
        a += 1
    end
    putmarker!(r)
    return a
end
function go_to_corner!() # Юго - западный угол.
    while ( !isborder(r, Sud) || !isborder(r, West) )
        if isborder(r, Sud) 
            move!(r, West)
        else
            move!(r, Sud) 
        end
    end
end
function shuttle!(stop_condition::Function, r, side)
    n = 0 
    while !stop_condition()
        n += 1
        moving!(r, side, n)
        side = reverse_side(side)
    end
end

"""
spiral!(stop_condition::Function, robot, side = Nord)
-- stop_condition:   stop_condition(::HorizonSide)::Bool
"""
function spiral!(stop_condition::Function, robot, side = Nord)
    n=1
    while true
        moving!(() -> stop_condition(side), robot, side, n)
        if stop_condition(side)
            return
        end        
        side = left(side)
        moving!(() -> stop_condition(side), robot, side, n)
        if stop_condition(side)
            return
        end        
        side = left(side)
        n += 1
    end
end