%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(version_handler).

-export([init/2]).
-export([content_types_provided/2]).
-export([version/2]).

init(Req, Opts) ->
	{cowboy_rest, Req, Opts}.

content_types_provided(Req, State) ->
	{[
		{<<"application/json">>, version}
	], Req, State}.

version(Req, State) ->
	Body = <<"{\"version\": \"0.1\"}">>,
	{Body, Req, State}.