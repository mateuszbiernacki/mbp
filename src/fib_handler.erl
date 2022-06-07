%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(fib_handler).

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
	Body = jiffy:encode(fib(H)),
	{Body, Req, State}.


fib(0) -> 0;
fib(1) -> 1;
fib(N) ->
    fib(N-1) + fib(N-2).