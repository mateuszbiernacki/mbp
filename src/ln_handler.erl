%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(ln_handler).

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
	[H| _] = maps:values(Map),
	Body = jiffy:encode(ln(H)),
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

ln(X) -> 
    ln(0, 1, X).
ln(Sum, 100, _) -> 2*Sum;
ln(Sum, I, X) ->  
    ln(Sum+((1)/(2*I-1))*pow((X-1)/(X+1), 2*I-1),I+1,X).

