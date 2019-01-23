%%%-------------------------------------------------------------------
%%% @author haroldverazamora
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. jun 2018 15:45
%%%-------------------------------------------------------------------
-module(reiner_handler).
-author("haroldverazamora").
-compile({parse_transform, lager_transform}).
%% API
-export([init/2]).


default(200, #{msg := Msg}, _Req, _Opts) ->
  {200, {ok, #{<<"msg">> => <<<<"Nice">>/binary,<<" -> ">>/binary,Msg/binary>>}}}.

response({Code, {_, Response}}, Req, Opts) ->
  Req0 = cowboy_req:reply(Code, #{<<"Content-Type">> => <<"application/json">>}, jiffy:encode(Response), Req),
  {ok, Req0, Opts}.

init(#{method := <<"GET">>} = Req0, Opts) ->
  response(
    default(200, cowboy_req:match_qs([msg], Req0), Req0, Opts),
    Req0,
    Opts
  );
init(Req, Opts) ->
  response({405, {error, #{<<"allow">> => <<"GET">>}}}, Req, Opts).
