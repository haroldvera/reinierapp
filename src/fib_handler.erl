%%%-------------------------------------------------------------------
%%% @author haroldverazamora
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. jun 2018 15:45
%%%-------------------------------------------------------------------
-module(fib_handler).
-author("haroldverazamora").
-compile({parse_transform, lager_transform}).
%% API
-export([init/2]).


fib(200, #{num := Num}, _Req, _Opts) ->
  {200, {ok, #{<<"fib">> => fib2:fib(binary_to_integer(Num))}}}.

response({Code, {_, Response}}, Req, Opts) ->
  Req0 = cowboy_req:reply(Code, #{<<"Content-Type">> => <<"application/json">>}, jiffy:encode(Response), Req),
  {ok, Req0, Opts}.

init(#{method := <<"GET">>} = Req0, Opts) ->
  response(
    fib(200, cowboy_req:match_qs([num], Req0), Req0, Opts),
    Req0,
    Opts
  );
init(Req, Opts) ->
  response({405, {error, #{<<"allow">> => <<"GET">>}}}, Req, Opts).
