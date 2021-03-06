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
            {"/division", div_handler, []},
            {"/is_prime", is_prime_handler, []},
            {"/next_prime", next_prime_handler, []},
            {"/factor", factor_handler, []},
            {"/sinus", sinus_handler, []},
            {"/cosinus", cosinus_handler, []},
            {"/tangens", tangens_handler, []},
            {"/cotangens", cotangens_handler, []},
            {"/sqrt", sqrt_handler, []},
            {"/pow", pow_handler, []},
            {"/fib", fib_handler, []},
            {"/ln", ln_handler, []},
            {"/log", log_handler, []}

        ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8081}],
        #{env => #{dispatch => Dispatch}}
    ),
    hello_erlang_sup:start_link().

stop(_State) ->
	ok.
