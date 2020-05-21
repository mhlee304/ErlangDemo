%%%-------------------------------------------------------------------
%%% @author matthewlee
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. May 2020 10:00 AM
%%%-------------------------------------------------------------------
-module(sockettest).
-author("matthewlee").

%% API
-export([client/0, server/0]).

client() ->
  {ok, Sock} = gen_tcp:connect({127,0,0,1}, 5678,
    [binary, {packet, 0}]), %connect to socket
  ok = gen_tcp:send(Sock, "What's up"),
  ok = gen_tcp:close(Sock).

server() ->
  {ok, LSock} = gen_tcp:listen(5678, [binary, {packet, 0},
    {active, false}]), %opens up socket to wait to accept
  {ok, Sock} = gen_tcp:accept(LSock),  %make sock LSock
  {ok, Bin} = do_recv(Sock, []), %do recieve and Bin=message
  ok = gen_tcp:close(Sock), %close socket
  ok = gen_tcp:close(LSock), %close listening socket
  Bin. %print out message

do_recv(Sock, Bs) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, B} -> %if the recv() is 'ok,B' add the additional message recieved into the full message
      do_recv(Sock, [Bs, B]); %repeat the process until the socket is closed and recieved an error
    {error, closed} -> %once recieved error send back message
      {ok, list_to_binary(Bs)}
  end.

