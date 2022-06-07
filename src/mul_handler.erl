%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(mul_handler).

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
	Values = maps:values(Map),
	Body = jiffy:encode(mul(Values)),
	{Body, Req, State}.

%H to pierwszy element listy, T to reszta listy
mul([H|T]) ->
	mul(T,H,1).

%cała lista została już przeiterowana, A to obecna suma, B to ostatni element listy
mul([], A, B) -> A * B;
%A to obecna suma, B to aktualnie iterowany element
mul([H|T], A, B) ->
	mul(T, A*B, H).