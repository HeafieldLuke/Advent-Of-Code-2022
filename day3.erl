-module(day3).
-export([solve/0, find_shared_item_type/2]).
-import(util, []).


split_into_compartments(Value) ->
    PartitionSize = length(Value) div 2,
    lists:split(PartitionSize, Value).

solve() ->
    Lines = util:read_lines("inputs/day3.txt", fun split_into_compartments/1),
    {part1(Lines, 0), part2(Lines, 0)}.

part1([], Acc) -> Acc;
part1([ {Compartment1, Compartment2} | Tail], Acc) ->
    CommonItemType = find_shared_item_type(Compartment1, Compartment2),
    part1(Tail, Acc + determine_priority(CommonItemType)).

part2([], Acc) -> Acc;
part2([ RuckSack1, RuckSack2, RuckSack3 | Tail], Acc) ->
    CommonItemType = find_common_item(RuckSack1, RuckSack2, RuckSack3),
    part2(Tail, Acc + determine_priority(CommonItemType)).

find_common_item({RS1L, RS1R}, {RS2L, RS2R}, {RS3L, RS3R}) ->
    RuckSack1 = sets:from_list(RS1L ++ RS1R),
    RuckSack2 = sets:from_list(RS2L ++ RS2R),
    RuckSack3 = sets:from_list(RS3L ++ RS3R),
    Intersection = sets:intersection([RuckSack1, RuckSack2, RuckSack3]),
    [CommonItemType] = sets:to_list(Intersection),
    CommonItemType.

find_shared_item_type([ Head | Tail ], Compartment2) ->
    case lists:member(Head, Compartment2) of
        true -> Head;
        false -> find_shared_item_type(Tail, Compartment2)
    end.

determine_priority(Item) when Item >= 97 -> Item - 96;
determine_priority(Item) when Item >= 65 -> Item - 38.
    
