%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(sqrt_handler).

-export([init/2]).
-export([content_types_provided/2]).
-export([ret/2]).

init(Req, Opts) ->
	{cowboy_rest, Req, Opts}.

content_types_provided(Req, State) ->
	{[
		{<<"application/json">>, ret}
	], Req, State}.

ret(Req, State) ->
	{ok, Data, _} = cowboy_req:read_body(Req),
	Map = jiffy:decode(Data, [return_maps]),
	[H | _] = maps:values(Map),
	
	Body = jiffy:encode(sqrt(H)),
	{Body, Req, State}.


sqrt(1) -> 1;
sqrt(N) ->
    X = N / 2,
    Err = 0.1,
    sqrt(N, X, Err).
sqrt(N, X, Err) ->
    if 
    abs(X - N / X) > Err ->
    X1 = (X + N / X)/2,
    if 
        X1*X1 =/= N -> sqrt(N, X1, Err);
        true -> X1
    end;
    true ->  X
    end.