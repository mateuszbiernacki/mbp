%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(sub_handler).

-export([init/2]).
-export([content_types_provided/2]).
-export([sub/2]).

init(Req, Opts) ->
	{cowboy_rest, Req, Opts}.

content_types_provided(Req, State) ->
	{[
		{<<"application/json">>, sub}
	], Req, State}.

sub(Req, State) ->
	{ok, Data, _} = cowboy_req:read_body(Req),
	Map = jiffy:decode(Data, [return_maps]),
	Values = maps:values(Map),
	Body = jiffy:encode(substr(Values)),
	{Body, Req, State}.

%H to pierwszy element listy, T to reszta listy
substr([H|T]) ->
	substr(T,H,0).

%cała lista została już przeiterowana, A to obecna różnica, B to ostatni element listy
substr([], A, B) -> A - B;
%A to obecna różnica, B to aktualnie iterowany element
substr([H|T], A, B) ->
	substr(T, A-B, H).