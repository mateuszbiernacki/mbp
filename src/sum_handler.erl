%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(sum_handler).

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
	Body = jiffy:encode(sum(Values)),
	{Body, Req, State}.

%H to pierwszy element listy, T to reszta listy
sum([H|T]) ->
	sum(T,H,0).

%cała lista została już przeiterowana, A to obecna suma, B to ostatni element listy
sum([], A, B) -> A + B;
%A to obecna suma, B to aktualnie iterowany element
sum([H|T], A, B) ->
	sum(T, A+B, H).