%%%-------------------------------------------------------------------
%%% @author matthewlee
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. May 2020 5:39 PM
%%%-------------------------------------------------------------------
-module(hello_world).
-author("matthewlee").

%% API
-export([hello/0]).
hello() -> io:fwrite("hello, world\n").

