%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(next_prime_handler).

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
	
	Body = jiffy:encode(nextprime(H)),
	{Body, Req, State}.


isprime(A) -> 
	if
		A > 1 -> isprime(A, A div 2);
		true -> false
	end.

isprime(_, 1) -> true;
isprime(A, I) ->
    Buff = A rem I,
    if 
        Buff == 0 -> false;
        true -> isprime(A, I-1)
    end.

nextprime(A) ->
    Buff = isprime(A),
    if
        Buff -> A;
        true -> nextprime(A+1)
    end.