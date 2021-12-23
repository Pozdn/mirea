using HorizonSideRobots
include("C:\\Users\\polex\\Desktop\\Julia\\Library.jl")
r=Robot(7,12;animate=true)

function start_1()
    for side in (Nord, West, Sud, Ost)
        krest(r, side)
    end
    putmarker!(r)
end

function krest(r, side)
    local counter = 0
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
        counter += 1
    end
    moving(r, reverse(side), counter)
end


function start_2()
    a = moving(r, Nord)
    box()
    moving(r, Sud, a)
end

function box()
    for side in (Ost, Sud, West, Nord, Ost)
        while !isborder(r, side) && !ismarker(r)
            putmarker!(r)
            move!(r, side)
        end
    end
end


function start_3()
    a = moving(r, Nord)
    b = moving(r, Ost)
    paint()
    moving(r, West, b)
    moving(r, Sud, a)
end

function paint()
while ( ( !isborder(r, Ost) | !isborder(r, West) ) & !isborder(r, Sud) ) | !ismarker(r)
    moving_paint(r, West)
    if isborder(r, Sud)
        moving(r, Ost)
        moving(r, Nord)
        break 
        end
    move!(r, Sud)
    moving_paint(r, Ost)
    if isborder(r, Sud)
        moving(r, Ost)
        moving(r, Nord)
        break 
        end
    move!(r, Sud)
    end
end


function start_4()
    a = moving(r, Sud)
    b = moving(r, West)
    corner()
    moving(r, Ost, b)
    moving(r, Nord, a) 
end

function corner()
    local count = moving_paint(r, Ost)
    while !isborder(r, Nord)
        moving(r, West)
        move!(r, Nord)
        count -= 1
        moving_paint(r, Ost, count)
    end
    moving(r, West)
    moving(r, Sud)
end


function start_5()
    a = go_to_corner_br(r)
    mark_angles(r)
    rev_go_to_corner(r, a)
end

function go_to_corner_br(r)
    local map = []
    while !(isborder(r, Nord) & isborder(r, West))
        if !isborder(r, Nord)
            move!(r, Nord)
            push!(map, 1)
        else
            move!(r, West)
            push!(map, 2)
        end
    end
    return map
end

function mark_angles(r)
    for Side in (Ost, Sud, West, Nord)
        putmarker!(r)
        moving(r, Side)
    end
end

function rev_go_to_corner(r, a)
    for i in (length(a):-1:1)
        if a[i] == 1 
            move!(r, Sud)
        else 
            move!(r, Ost) 
        end
    end
end