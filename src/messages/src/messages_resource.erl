%% @author Neil Robbins <neil@computer.org>
%% @author Anthony Steele <anthony@plasticavenue.org>
%% @copyright 2011 Neil Robbins & Anthony Steele.
%% @doc Handle posted messages

-module(messages_resource).
-export([init/1]).
-export([to_html/2,
	 post_is_create/2,
	 create_path/2,
	 allowed_methods/2,
	 content_types_accepted/2,
	 handle_form_post/2,
	 resource_exists/2,
	 allow_missing_post/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(State) ->
    {{trace, "/tmp"}, State}.

resource_exists(ReqData, State) ->
    {false, ReqData, State}.

allow_missing_post(ReqData, State) ->
    {true, ReqData, State}.

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>", ReqData, State}.

content_types_accepted(ReqData, State) ->
    CT = case wrq:get_req_header("content-type", ReqData) of
	    undefined -> "application/x-www-form-urlencoded";
	    X -> X
	 end,
    {MT, _Params} = webmachine_util:media_type_to_detail(CT),
    {[{MT, handle_form_post}], ReqData, State}.

handle_form_post(ReqData, State) ->
    ResponseBody = wrq:req_body(ReqData),
    ResponseData = wrq:set_resp_header("Location", "http://localhost:8000/messages/1", ReqData),
    {true, wrq:set_resp_body(ResponseBody, ResponseData), State}.

allowed_methods(ReqData, State) ->
    {['HEAD', 'GET','POST','PUT'], ReqData, State}.

post_is_create(ReqData, State) ->
    {true, ReqData, State}.

create_path(ReqData, State) ->
	{"Foo", ReqData, State}.
