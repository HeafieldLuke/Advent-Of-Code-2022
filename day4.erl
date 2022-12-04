-module(day4).
-export([solve/0]).
-import(util, []).

formatRangePairs(Value) ->
    [Range1, Range2] = string:split(Value, ","),
    {getRange(Range1), getRange(Range2)}.

getRange(RangeString) ->
    [Lower, Upper] = string:split(RangeString, "-"),
    {list_to_integer(Lower), list_to_integer(Upper)}.

solve() ->
    Lines = util:read_lines("inputs/day4.txt", fun formatRangePairs/1),
    {lists:foldl(fun part1/2, 0, Lines), lists:foldl(fun part2/2, 0, Lines)}.

part1({Range1, Range2}, Acc) -> 
    Acc + is_fully_contained(Range1, Range2).

part2({Range1, Range2}, Acc) -> 
    Acc + has_any_overlap(Range1, Range2).

has_any_overlap({Lower1, Upper1}, {Lower2, Upper2}) ->
    Range1 = lists:seq(Lower1, Upper1),
    Range2 = lists:seq(Lower2, Upper2),
    Intersection = sets:intersection(sets:from_list(Range1), sets:from_list(Range2)),
    case sets:to_list(Intersection) of
        [] -> 0;
        _ -> 1
    end.

is_fully_contained({Lower1, Upper1}, {Lower2, Upper2}) ->
    if 
        (Lower1 =< Lower2) and (Upper1 >= Upper2) -> 1;
        (Lower2 =< Lower1) and (Upper2 >= Upper1) -> 1;
        true -> 0
    end. 