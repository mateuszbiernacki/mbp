-module(hello_erlang_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).


start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", hello_handler, []},
            {"/substriction", sub_handler, []},
            {"/addition", sum_handler, []},
            {"/multiplication", mul_handler, []},
            {"/division", div_handler, []}
            % {"/sinus", sin_handler, []},
            % {"/cosinus", cos_handler, []},
            % {"/next_prime", next_prime_world, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8081}],
        #{env => #{dispatch => Dispatch}}
    ),
    hello_erlang_sup:start_link().

stop(_State) ->
	ok.
