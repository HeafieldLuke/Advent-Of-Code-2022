
-module(util).
-export([read_lines/2]).

read_lines(FileName, TransformFxn) ->
    {ok, Data} = file:read_file(FileName),
    [ TransformFxn(erlang:binary_to_list(V)) || V <- binary:split(Data, [<<"\n">>], [global])].