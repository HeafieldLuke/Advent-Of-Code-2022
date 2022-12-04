-module(day2).
-export([solve/0]).
-import(util, []).

formatInput(Value) ->
    string:split(Value, " ").

solve() ->
    Lines = util:read_lines("inputs/day2.txt", fun formatInput/1),
    {part1(Lines, 0), part2(Lines, 0)}.

part1([], TotalScore) -> TotalScore;
part1([ [OpponentMove, MyMove] | Tail], TotalScore) -> part1(Tail, calculate_round_score(OpponentMove, MyMove) + TotalScore).

part2([], TotalScore) -> TotalScore;
part2([ [OpponentMove, "X"] | Tail], TotalScore) -> part2(Tail, calculate_loss_score(OpponentMove) + TotalScore);
part2([ [OpponentMove, "Y"] | Tail], TotalScore) -> part2(Tail, calculate_round_score(OpponentMove, OpponentMove) + TotalScore);
part2([ [OpponentMove, "Z"] | Tail], TotalScore) -> part2(Tail, calculate_win_score(OpponentMove) + TotalScore).

calculate_win_score("A") -> calculate_round_score("A", "B");
calculate_win_score("B") -> calculate_round_score("B", "C");
calculate_win_score("C") -> calculate_round_score("C", "A").

calculate_loss_score("A") -> calculate_round_score("A", "C");
calculate_loss_score("B") -> calculate_round_score("B", "A");
calculate_loss_score("C") -> calculate_round_score("C", "B").


calculate_round_score(OpponentMove, MyMove) -> 
    MyScore = calculate_move_score(MyMove),
    OpponentScore = calculate_move_score(OpponentMove),
    MyScore + play(MyScore, OpponentScore).

play(1, 3) -> 6;
play(2, 1) -> 6;
play(3, 2) -> 6;
play(MyMove, OpponentMove) when MyMove == OpponentMove -> 3;
play(_, _) -> 0.

calculate_move_score("A") -> 1;
calculate_move_score("X") -> 1;
calculate_move_score("B") -> 2;
calculate_move_score("Y") -> 2;
calculate_move_score("C") -> 3;
calculate_move_score("Z") -> 3.

    

