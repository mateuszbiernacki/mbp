%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(pow_handler).

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
	[H, K | _] = maps:values(Map),
	Body = jiffy:encode(pow(H,K)),
	{Body, Req, State}.


pow(A, B) ->
    Res = 1,
    pow(A, B, Res).

pow(A, B, Res) ->
    if
        B > 0 ->
        Res1 = Res * A,
        B1 = B - 1,
        pow(A, B1, Res1);
        true -> Res
    end.