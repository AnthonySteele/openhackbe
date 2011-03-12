%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the messages application.

-module(messages_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for messages.
start(_Type, _StartArgs) ->
    messages_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for messages.
stop(_State) ->
    ok.
