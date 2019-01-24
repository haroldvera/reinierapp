%%%-------------------------------------------------------------------
%% @doc reinierapp public API
%% @end
%%%-------------------------------------------------------------------

-module(reinierapp_app).

-behaviour(application).
-compile({parse_transform, lager_transform}).
%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
  start_webui(),
    reinierapp_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

start_webui() ->
  lager:info("starting web server ~p port",[os:getenv("WEB_PORT")]),
  cowboy:start_clear(http, [{port, list_to_integer(os:getenv("WEB_PORT"))}], #{
    metrics_callback => do_metrics_callback(),
    stream_handlers => [cowboy_metrics_h, cowboy_stream_h],
    env => #{dispatch => cowboy_router:compile([
      {'_', [
        {"/reinerservice/echo", reiner_handler, []},
        {"/reinerservice/fib", fib_handler, []},
        {"/", default_handler, []}
      ]}
    ])}
  }).
do_metrics_callback() ->
  fun(Metrics) ->
    error_logger:error_msg("@@ metrics~n~p~n", [Metrics]),
    ok
  end.