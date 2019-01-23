%%%-------------------------------------------------------------------
%%% @author haroldverazamora
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. jun 2018 15:45
%%%-------------------------------------------------------------------
-module(default_handler).
-author("haroldverazamora").
-compile({parse_transform, lager_transform}).
%% API
-export([init/2]).


default(200, _, _Req, _Opts) ->
  lager:info("default ping ~p",[<<"ping">>]),
  {200, {ok, #{<<"msg">> => <<"pong">>}}}.

response({Code, {_, Response}}, Req, Opts) ->
  Req0 = cowboy_req:reply(Code, #{<<"Content-Type">> => <<"application/json">>}, jiffy:encode(Response), Req),
  {ok, Req0, Opts}.

init(#{method := <<"GET">>} = Req0, Opts) ->
  response(
    default(200, ok, Req0, Opts),
    Req0,
    Opts
  );
init(Req, Opts) ->
  response({405, {error, #{<<"allow">> => <<"GET">>}}}, Req, Opts).
