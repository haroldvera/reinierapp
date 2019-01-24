%%%-------------------------------------------------------------------
%%% @author haroldverazamora
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. Jan 2019 21:06
%%%-------------------------------------------------------------------
-module(fib2).
-author("haroldverazamora").

%% API



-export([fib/1]).

fib(N) -> fib_iter(N, 0, 1).

fib_iter(0, Result, _Next) -> Result;
fib_iter(Iter, Result, Next) when Iter > 0 ->
  fib_iter(Iter-1, Next, Result+Next).