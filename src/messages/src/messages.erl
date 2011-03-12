%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc messages startup code

-module(messages).
-author('author <author@example.com>').
-export([start/0, start_link/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    messages_sup:start_link().

%% @spec start() -> ok
%% @doc Start the messages server.
start() ->
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    application:start(messages).

%% @spec stop() -> ok
%% @doc Stop the messages server.
stop() ->
    Res = application:stop(messages),
    application:stop(webmachine),
    application:stop(mochiweb),
    application:stop(crypto),
    Res.
