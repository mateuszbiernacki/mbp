%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(sinus_handler).

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
	
	Body = jiffy:encode(sinus(H)),
	{Body, Req, State}.


posred(Rad) ->
    if
        Rad < 2*3.14159265358979323846264338327950288419716939937510582097494 -> Rad;
        true -> posred(Rad - 2*3.14159265358979323846264338327950288419716939937510582097494)
    end.
    
negred(Rad) ->
    if
        Rad > -2*3.14159265358979323846264338327950288419716939937510582097494 -> Rad;
        true -> negred(Rad + 2*3.14159265358979323846264338327950288419716939937510582097494)
    end.
    
reg(Rad) ->
    if
        Rad > 0 -> posred(Rad);
        true -> negred(Rad)
    end.
    
sinus(Rad) -> 
    Rr = reg(Rad),
    sinus(Rr, Rr, 2, 0).
    
sinus(_, _, 10000, Sum) -> Sum;
sinus(Rad, Last, I, Sum) ->
    sinus(Rad, -1*Last*(Rad*Rad)/((2*I-2)*(2*I-1)), I+1, Sum+Last).