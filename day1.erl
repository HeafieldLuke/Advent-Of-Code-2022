
-module(day1).
-export([solve/0]).

readLines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    [ erlang:binary_to_list(V) || V <- binary:split(Data, [<<"\n">>], [global])].

solve() ->
    Lines = readLines("inputs/day1.txt"),
    {part1(Lines, 0, 0), part2(Lines, {0, 0, 0}, 0)}.

part1([], CurrentMax, _) -> CurrentMax;
part1(["" | Tail], CurrentMax, Acc) when Acc > CurrentMax -> part1(Tail, Acc, 0);
part1(["" | Tail], CurrentMax, _) -> part1(Tail, CurrentMax, 0);
part1([Head | Tail], CurrentMax, Acc) -> part1(Tail, CurrentMax, Acc + erlang:list_to_integer(Head)).

part2([], {Max, SecondMax, ThirdMax}, _) -> Max + SecondMax + ThirdMax;
part2(["" | Tail], Maxes, Acc) -> part2(Tail, adjust_top_3_calories(Acc, Maxes), 0);
part2([Head | Tail], Maxes, Acc) -> part2(Tail, Maxes, Acc + erlang:list_to_integer(Head)).

adjust_top_3_calories(Value, {Max, SecondMax, _}) when Value > Max -> {Value, Max, SecondMax};
adjust_top_3_calories(Value, {Max, SecondMax, _}) when Value > SecondMax -> {Max, Value, SecondMax};
adjust_top_3_calories(Value, {Max, SecondMax, ThirdMax}) when Value > ThirdMax -> {Max, SecondMax, Value};
adjust_top_3_calories(_, Maxes) -> Maxes.



