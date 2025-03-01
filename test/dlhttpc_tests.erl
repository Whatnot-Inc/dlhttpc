%%% ----------------------------------------------------------------------------
%%% Copyright (c) 2009, Erlang Training and Consulting Ltd.
%%% All rights reserved.
%%%
%%% Redistribution and use in source and binary forms, with or without
%%% modification, are permitted provided that the following conditions are met:
%%%    * Redistributions of source code must retain the above copyright
%%%      notice, this list of conditions and the following disclaimer.
%%%    * Redistributions in binary form must reproduce the above copyright
%%%      notice, this list of conditions and the following disclaimer in the
%%%      documentation and/or other materials provided with the distribution.
%%%    * Neither the name of Erlang Training and Consulting Ltd. nor the
%%%      names of its contributors may be used to endorse or promote products
%%%      derived from this software without specific prior written permission.
%%%
%%% THIS SOFTWARE IS PROVIDED BY Erlang Training and Consulting Ltd. ''AS IS''
%%% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%%% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%%% ARE DISCLAIMED. IN NO EVENT SHALL Erlang Training and Consulting Ltd. BE
%%% LIABLE SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
%%% BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
%%% WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
%%% OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
%%% ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%% ----------------------------------------------------------------------------

%%% @author Oscar Hellstrom <oscar@hellstrom.st>
-module(dlhttpc_tests).

-export([test_no/2]).
-import(webserver, [start/2]).

-include_lib("eunit/include/eunit.hrl").

-define(DEFAULT_STRING, "Great success!").
-define(LONG_BODY_PART,
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
        "This is a relatively long body, that we send to the client... "
    ).

test_no(N, Tests) ->
    setelement(2, Tests,
        setelement(4, element(2, Tests),
            lists:nth(N, element(4, element(2, Tests))))).

%%% Eunit setup stuff

start_app() ->
    {ok, _} = application:ensure_all_started(ssl),
    {ok, _} = application:ensure_all_started(dispcount),
    %% application:set_env(dlhttpc, maxr, 1, [{persistent, true}]),
    ok = dlhttpc:start().

stop_app(_) ->
    ok = dlhttpc:stop(),
    ok = application:stop(ssl).

tcp_test_() ->
    {inorder,
        {setup, fun start_app/0, fun stop_app/1, [
                ?_test(simple_get()),
                ?_test(empty_get()),
                ?_test(get_with_mandatory_hdrs()),
                ?_test(get_with_connect_options()),
                ?_test(no_content_length()),
                ?_test(no_content_length_1_0()),
                ?_test(get_not_modified()),
                ?_test(simple_head()),
                ?_test(simple_head_atom()),
                ?_test(delete_no_content()),
                ?_test(delete_content()),
                ?_test(options_content()),
                ?_test(options_no_content()),
                ?_test(server_connection_close()),
                ?_test(client_connection_close()),
                ?_test(pre_1_1_server_connection()),
                ?_test(pre_1_1_server_keep_alive()),
                ?_test(simple_put()),
                ?_test(post()),
                ?_test(post_100_continue()),
                ?_test(bad_url()),
                ?_test(persistent_connection()),
                ?_test(request_timeout()),
                ?_test(chunked_encoding()),
                ?_test(partial_upload_identity()),
                ?_test(partial_upload_identity_iolist()),
                ?_test(partial_upload_chunked()),
                ?_test(partial_upload_chunked_no_trailer()),
                ?_test(partial_download_illegal_option()),
                ?_test(partial_download_identity()),
                ?_test(partial_download_infinity_window()),
                ?_test(partial_download_no_content_length()),
                ?_test(partial_download_no_content()),
                ?_test(limited_partial_download_identity()),
                ?_test(partial_download_chunked()),
                ?_test(partial_download_chunked_infinite_part()),
                ?_test(partial_download_smallish_chunks()),
                ?_test(partial_download_slow_chunks()),
                ?_test(close_connection()),
                ?_test(proxy_request()),
                ?_test(proxy_request_with_port()),
                ?_test(non_default_pool_name_request()),
                ?_test(message_queue())
            ]}
    }.

ssl_test_() ->
    {inorder,
        {setup, fun start_app/0, fun stop_app/1, [
                ?_test(ssl_get()),
                ?_test(ssl_post()),
                ?_test(ssl_post_with_no_peer_verify()),
                ?_test(ssl_post_with_invalid_connect_option()),
                ?_test(ssl_chunked())
            ]}
    }.

other_test_() ->
    [
        ?_test(invalid_options())
    ].

%%% Tests

message_queue() ->
    receive X -> erlang:error({unexpected_message, X}) after 0 -> ok end.

simple_get() ->
    simple(get),
    simple("GET").

empty_get() ->
    Port = start(gen_tcp, [fun empty_body/5]),
    URL = url(Port, "/empty"),
    {ok, Response} = dlhttpc:request(URL, "GET", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

get_with_mandatory_hdrs() ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = url(Port, "/host"),
    Body = <<?DEFAULT_STRING>>,
    Hdrs = [
        {"content-length", integer_to_list(size(Body))},
        {"host", "localhost"}
    ],
    {ok, Response} = dlhttpc:request(URL, "POST", Hdrs, Body, 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

get_with_connect_options() ->
    Port = start(gen_tcp, [fun empty_body/5]),
    URL = url(Port, "/empty"),
    Options = [{connect_options, [{ip, {127, 0, 0, 1}}, {port, 0}]}],
    {ok, Response} = dlhttpc:request(URL, "GET", [], [], 1000, Options),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

no_content_length() ->
    Port = start(gen_tcp, [fun no_content_length/5]),
    URL = url(Port, "/no_cl"),
    {ok, Response} = dlhttpc:request(URL, "GET", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

no_content_length_1_0() ->
    Port = start(gen_tcp, [fun no_content_length_1_0/5]),
    URL = url(Port, "/no_cl"),
    {ok, Response} = dlhttpc:request(URL, "GET", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

get_not_modified() ->
    Port = start(gen_tcp, [fun not_modified_response/5]),
    URL = url(Port, "/not_modified"),
    {ok, Response} = dlhttpc:request(URL, "GET", [], [], 1000),
    ?assertEqual({304, "Not Modified"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

simple_head() ->
    Port = start(gen_tcp, [fun head_response/5]),
    URL = url(Port, "/HEAD"),
    {ok, Response} = dlhttpc:request(URL, "HEAD", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

simple_head_atom() ->
    Port = start(gen_tcp, [fun head_response/5]),
    URL = url(Port, "/head"),
    {ok, Response} = dlhttpc:request(URL, head, [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

delete_no_content() ->
    Port = start(gen_tcp, [fun no_content_response/5]),
    URL = url(Port, "/delete_no_content"),
    {ok, Response} = dlhttpc:request(URL, delete, [], 1000),
    ?assertEqual({204, "OK"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

delete_content() ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = url(Port, "/delete_content"),
    {ok, Response} = dlhttpc:request(URL, "DELETE", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

options_no_content() ->
    Port = start(gen_tcp, [fun head_response/5]),
    URL = url(Port, "/options_no_content"),
    {ok, Response} = dlhttpc:request(URL, "OPTIONS", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<>>, body(Response)).

options_content() ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = url(Port, "/options_content"),
    {ok, Response} = dlhttpc:request(URL, "OPTIONS", [], 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

server_connection_close() ->
    Port = start(gen_tcp, [fun respond_and_close/5]),
    URL = url(Port, "/close"),
    Body = pid_to_list(self()),
    {ok, Response} = dlhttpc:request(URL, "PUT", [], Body, 1000),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)),
    receive closed -> ok end.

client_connection_close() ->
    Port = start(gen_tcp, [fun respond_and_wait/5]),
    URL = url(Port, "/close"),
    Body = pid_to_list(self()),
    Hdrs = [{"Connection", "close"}],
    {ok, _} = dlhttpc:request(URL, put, Hdrs, Body, 1000),
    % Wait for the server to see that socket has been closed
    receive closed -> ok end.

pre_1_1_server_connection() ->
    Port = start(gen_tcp, [fun pre_1_1_server/5]),
    URL = url(Port, "/close"),
    Body = pid_to_list(self()),
    {ok, _} = dlhttpc:request(URL, put, [], Body, 1000),
    % Wait for the server to see that socket has been closed.
    % The socket should be closed by us since the server responded with a
    % 1.0 version, and not the Connection: keep-alive header.
    receive closed -> ok end.

pre_1_1_server_keep_alive() ->
    Port = start(gen_tcp, [
            fun pre_1_1_server_keep_alive/5,
            fun pre_1_1_server/5
        ]),
    URL = url(Port, "/close"),
    Body = pid_to_list(self()),
    {ok, Response1} = dlhttpc:request(URL, get, [], [], 2000, [{max_connections, 1}]),
    {ok, Response2} = dlhttpc:request(URL, put, [], Body, 2000, [{max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(Response1)),
    ?assertEqual({200, "OK"}, status(Response2)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response1)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response2)),
    % Wait for the server to see that socket has been closed.
    % The socket should be closed by us since the server responded with a
    % 1.0 version, and not the Connection: keep-alive header.
    timer:sleep(1000),
    receive closed -> ok end.

simple_put() ->
    simple(put),
    simple("PUT").

post() ->
    Port = start(gen_tcp, [fun copy_body/5]),
    URL = url(Port, "/post"),
    {X, Y, Z} = now(),
    Body = [
        "This is a rather simple post :)",
        integer_to_list(X),
        integer_to_list(Y),
        integer_to_list(Z)
    ],
    {ok, Response} = dlhttpc:request(URL, "POST", [], Body, 1000),
    {StatusCode, ReasonPhrase} = status(Response),
    ?assertEqual(200, StatusCode),
    ?assertEqual("OK", ReasonPhrase),
    ?assertEqual(iolist_to_binary(Body), body(Response)).

post_100_continue() ->
    Port = start(gen_tcp, [fun copy_body_100_continue/5]),
    URL = url(Port, "/post"),
    {X, Y, Z} = now(),
    Body = [
        "This is a rather simple post :)",
        integer_to_list(X),
        integer_to_list(Y),
        integer_to_list(Z)
    ],
    {ok, Response} = dlhttpc:request(URL, "POST", [], Body, 1000),
    {StatusCode, ReasonPhrase} = status(Response),
    ?assertEqual(200, StatusCode),
    ?assertEqual("OK", ReasonPhrase),
    ?assertEqual(iolist_to_binary(Body), body(Response)).

bad_url() ->
    ?assertError(_, dlhttpc:request(ost, "GET", [], 100)).

persistent_connection() ->
    Port = start(gen_tcp, [
            fun simple_response/5,
            fun simple_response/5,
            fun copy_body/5
        ]),
    URL = url(Port, "/persistent"),
    {ok, FirstResponse} = dlhttpc:request(URL, "GET", [], [], 1000, [{max_connections, 1}]),
    Headers = [{"KeepAlive", "300"}], % shouldn't be needed
    {ok, SecondResponse} = dlhttpc:request(URL, "GET", Headers, [], 1000, [{max_connections, 1}]),
    {ok, ThirdResponse} = dlhttpc:request(URL, "POST", [], [], 1000, [{max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(FirstResponse)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(FirstResponse)),
    ?assertEqual({200, "OK"}, status(SecondResponse)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(SecondResponse)),
    ?assertEqual({200, "OK"}, status(ThirdResponse)),
    ?assertEqual(<<>>, body(ThirdResponse)).

request_timeout() ->
    Port = start(gen_tcp, [fun very_slow_response/5]),
    URL = url(Port, "/slow"),
    ?assertEqual({error, timeout}, dlhttpc:request(URL, get, [], 50)).

chunked_encoding() ->
    Port = start(gen_tcp, [fun chunked_response/5, fun chunked_response_t/5]),
    URL = url(Port, "/chunked"),
    {ok, FirstResponse} = dlhttpc:request(URL, get, [], [], 50, [{max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(FirstResponse)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(FirstResponse)),
    ?assertEqual("chunked", dlhttpc_lib:header_value("transfer-encoding",
            headers(FirstResponse))),
    {ok, SecondResponse} = dlhttpc:request(URL, get, [], [], 50, [{max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(SecondResponse)),
    ?assertEqual(<<"Again, great success!">>, body(SecondResponse)),
    ?assertEqual("ChUnKeD", dlhttpc_lib:header_value("transfer-encoding",
            headers(SecondResponse))),
    ?assertEqual("1", dlhttpc_lib:header_value("trailer-1",
            headers(SecondResponse))),
    ?assertEqual("2", dlhttpc_lib:header_value("trailer-2",
            headers(SecondResponse))).

partial_upload_identity() ->
    Port = start(gen_tcp, [fun simple_response/5, fun simple_response/5]),
    URL = url(Port, "/partial_upload"),
    Body = [<<"This">>, <<" is ">>, <<"chunky">>, <<" stuff!">>],
    Hdrs = [{"Content-Length", integer_to_list(iolist_size(Body))}],
    Options = [{max_connections, 1}, {partial_upload, 1}],
    {ok, UploadState1} = dlhttpc:request(URL, post, Hdrs, hd(Body), 1000, Options),
    Response1 = lists:foldl(fun upload_parts/2, UploadState1,
        tl(Body) ++ [http_eob]),
    ?assertEqual({200, "OK"}, status(Response1)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response1)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response1))),
    % Make sure it works with no body part in the original request as well
    {ok, UploadState2} = dlhttpc:request(URL, post, Hdrs, [], 1000, Options),
    Response2 = lists:foldl(fun upload_parts/2, UploadState2,
        Body ++ [http_eob]),
    ?assertEqual({200, "OK"}, status(Response2)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response2)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response2))).

partial_upload_identity_iolist() ->
    Port = start(gen_tcp, [fun simple_response/5, fun simple_response/5]),
    URL = url(Port, "/partial_upload"),
    Body = ["This", [<<" ">>, $i, $s, [" "]], <<"chunky">>, [<<" stuff!">>]],
    Hdrs = [{"Content-Length", integer_to_list(iolist_size(Body))}],
    Options = [{partial_upload, 1}],
    {ok, UploadState1} = dlhttpc:request(URL, post, Hdrs, hd(Body), 1000, [{max_connections, 1}|Options]),
    Response1 = lists:foldl(fun upload_parts/2, UploadState1,
        tl(Body) ++ [http_eob]),
    ?assertEqual({200, "OK"}, status(Response1)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response1)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response1))),
    % Make sure it works with no body part in the original request as well
    {ok, UploadState2} = dlhttpc:request(URL, post, Hdrs, [], 1000, [{max_connections, 1}|Options]),
    Response2 = lists:foldl(fun upload_parts/2, UploadState2,
        Body ++ [http_eob]),
    ?assertEqual({200, "OK"}, status(Response2)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response2)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response2))).

partial_upload_chunked() ->
    Port = start(gen_tcp, [fun chunked_upload/5, fun chunked_upload/5]),
    URL = url(Port, "/partial_upload_chunked"),
    Body = ["This", [<<" ">>, $i, $s, [" "]], <<"chunky">>, [<<" stuff!">>]],
    Options = [{max_connections, 1}, {partial_upload, 1}],
    {ok, UploadState1} = dlhttpc:request(URL, post, [], hd(Body), 1000, Options),
    Trailer = {"X-Trailer-1", "my tail is tailing me...."},
    {ok, Response1} = dlhttpc:send_trailers(
        lists:foldl(fun upload_parts/2, UploadState1, tl(Body)),
        [Trailer]
    ),
    ?assertEqual({200, "OK"}, status(Response1)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response1)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response1))),
    ?assertEqual(element(2, Trailer),
        dlhttpc_lib:header_value("x-test-orig-trailer-1", headers(Response1))),
    % Make sure it works with no body part in the original request as well
    Headers = [{"Transfer-Encoding", "chunked"}],
    {ok, UploadState2} = dlhttpc:request(URL, post, Headers, [], 1000, Options),
    {ok, Response2} = dlhttpc:send_trailers(
        lists:foldl(fun upload_parts/2, UploadState2, Body),
        [Trailer]
    ),
    ?assertEqual({200, "OK"}, status(Response2)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response2)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response2))),
    ?assertEqual(element(2, Trailer),
        dlhttpc_lib:header_value("x-test-orig-trailer-1", headers(Response2))).

partial_upload_chunked_no_trailer() ->
    Port = start(gen_tcp, [fun chunked_upload/5]),
    URL = url(Port, "/partial_upload_chunked_no_trailer"),
    Body = [<<"This">>, <<" is ">>, <<"chunky">>, <<" stuff!">>],
    Options = [{partial_upload, 1}],
    {ok, UploadState1} = dlhttpc:request(URL, post, [], hd(Body), 1000, Options),
    {ok, Response} = dlhttpc:send_body_part(
        lists:foldl(fun upload_parts/2, UploadState1, tl(Body)),
        http_eob
    ),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)),
    ?assertEqual("This is chunky stuff!",
        dlhttpc_lib:header_value("x-test-orig-body", headers(Response))).

partial_download_illegal_option() ->
    ?assertError({bad_options, [{partial_download, [{foo, bar}]}]},
        dlhttpc:request("http://localhost/", get, [], <<>>, 1000,
            [{partial_download, [{foo, bar}]}])).

partial_download_identity() ->
    Port = start(gen_tcp, [fun large_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, 1}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} =
        dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

partial_download_infinity_window() ->
    Port = start(gen_tcp, [fun large_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, infinity}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} = dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

partial_download_no_content_length() ->
    Port = start(gen_tcp, [fun no_content_length/5]),
    URL = url(Port, "/no_cl"),
    PartialDownload = [
        {window_size, 1}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} = dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?DEFAULT_STRING>>, Body).

partial_download_no_content() ->
    Port = start(gen_tcp, [fun no_content_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, 1}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Body}} =
        dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    ?assertEqual({204, "OK"}, Status),
    ?assertEqual(undefined, Body).

limited_partial_download_identity() ->
    Port = start(gen_tcp, [fun large_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, 1},
        {part_size, 512} % bytes
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} =
        dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid, 512),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

partial_download_chunked() ->
    Port = start(gen_tcp, [fun large_chunked_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, 1},
        {part_size, length(?LONG_BODY_PART) * 3}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} =
        dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

partial_download_chunked_infinite_part() ->
    Port = start(gen_tcp, [fun large_chunked_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, 1},
        {part_size, infinity}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} =
        dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

partial_download_smallish_chunks() ->
    Port = start(gen_tcp, [fun large_chunked_response/5]),
    URL = url(Port, "/partial_download_identity"),
    PartialDownload = [
        {window_size, 1},
        {part_size, length(?LONG_BODY_PART) - 1}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} =
        dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

partial_download_slow_chunks() ->
    Port = start(gen_tcp, [fun slow_chunked_response/5]),
    URL = url(Port, "/slow"),
    PartialDownload = [
        {window_size, 1},
        {part_size, length(?LONG_BODY_PART) div 2}
    ],
    Options = [{partial_download, PartialDownload}],
    {ok, {Status, _, Pid}} = dlhttpc:request(URL, get, [], <<>>, 1000, Options),
    Body = read_partial_body(Pid),
    ?assertEqual({200, "OK"}, Status),
    ?assertEqual(<<?LONG_BODY_PART ?LONG_BODY_PART>>, Body).

close_connection() ->
    Port = start(gen_tcp, [fun close_connection/5]),
    URL = url(Port, "/close"),
    ?assertEqual({error, connection_closed}, dlhttpc:request(URL, "GET", [],
            1000)).

proxy_request() ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = "http://httpbin.org/get",
    {ok, Response} = dlhttpc:request(URL, "GET", [], "", 1000, [{proxy, url(Port, "/")}]),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)),
    ?assertEqual("http://httpbin.org/get",
        dlhttpc_lib:header_value("x-test-orig-uri", headers(Response))).

proxy_request_with_port() ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = "http://httpbin.org:80/get",
    {ok, Response} = dlhttpc:request(URL, "GET", [], "", 1000, [{proxy, url(Port, "/")}]),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)),
    ?assertEqual("http://httpbin.org:80/get",
        dlhttpc_lib:header_value("x-test-orig-uri", headers(Response))).

non_default_pool_name_request() ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = url(Port,"/simple"),
    {ok, Response} = dlhttpc:request(URL, "GET", [], "", 1000, [{pool_name, non_default}]),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

ssl_get() ->
    Port = start(ssl, [fun simple_response/5]),
    URL = ssl_url(Port, "/simple"),
    {ok, Response} = dlhttpc:request(URL, "GET", [], [], 1000, [{max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

ssl_post() ->
    Port = start(ssl, [fun copy_body/5]),
    URL = ssl_url(Port, "/simple"),
    Body = "SSL Test <o/",
    BinaryBody = list_to_binary(Body),
    {ok, Response} = dlhttpc:request(URL, "POST", [], Body, 1000, [{max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(BinaryBody, body(Response)).

ssl_post_with_no_peer_verify() ->
    Port = start(ssl, [fun copy_body/5]),
    URL = ssl_url(Port, "/simple"),
    Body = "SSL Test <o/",
    BinaryBody = list_to_binary(Body),
    {ok, Response} = dlhttpc:request(URL, "POST", [], Body, 1000, [{connect_options, [{verify, verify_none}]},
                                                                   {max_connections, 1}]),
    ?assertEqual({200, "OK"}, status(Response)),
    ?assertEqual(BinaryBody, body(Response)).

ssl_post_with_invalid_connect_option() ->
    Port = start(ssl, [fun copy_body/5]),
    URL = ssl_url(Port, "/simple"),
    Body = "SSL Test <o/",
    BinaryBody = list_to_binary(Body),
    Error =
     dlhttpc:request(URL, "POST", [], Body, 1000, [{connect_options, [{verify, silly_option}]},
                                                                   {max_connections, 1}]),
    ?assertEqual({error,{options,{verify,silly_option}}}, Error).


ssl_chunked() ->
    Port = start(ssl, [fun chunked_response/5, fun chunked_response_t/5]),
    URL = ssl_url(Port, "/ssl_chunked"),
    Options = [{max_connections, 1}],
    FirstResult = dlhttpc:request(URL, get, [], [], 100, Options),
    ?assertMatch({ok, _}, FirstResult),
    {ok, FirstResponse} = FirstResult,
    ?assertEqual({200, "OK"}, status(FirstResponse)),
    ?assertEqual(<<?DEFAULT_STRING>>, body(FirstResponse)),
    ?assertEqual("chunked", dlhttpc_lib:header_value("transfer-encoding",
            headers(FirstResponse))),
    timer:sleep(500),
    SecondResult = dlhttpc:request(URL, get, [], [], 100, Options),
    {ok, SecondResponse} = SecondResult,
    ?assertEqual({200, "OK"}, status(SecondResponse)),
    ?assertEqual(<<"Again, great success!">>, body(SecondResponse)),
    ?assertEqual("ChUnKeD", dlhttpc_lib:header_value("transfer-encoding",
            headers(SecondResponse))),
    ?assertEqual("1", dlhttpc_lib:header_value("Trailer-1",
            headers(SecondResponse))),
    ?assertEqual("2", dlhttpc_lib:header_value("Trailer-2",
            headers(SecondResponse))).


invalid_options() ->
    ?assertError({bad_options, [{foo, bar}, bad_option]},
        dlhttpc:request("http://localhost/", get, [], <<>>, 1000,
            [bad_option, {foo, bar}])).

%%% Helpers functions

upload_parts(BodyPart, CurrentState) ->
    {ok, NextState} = dlhttpc:send_body_part(CurrentState, BodyPart, 1000),
    NextState.

read_partial_body(Pid) ->
    read_partial_body(Pid, infinity, []).

read_partial_body(Pid, Size) ->
    read_partial_body(Pid, Size, []).

read_partial_body(Pid, Size, Acc) ->
    case dlhttpc:get_body_part(Pid) of
        {ok, {http_eob, []}} ->
            list_to_binary(Acc);
        {ok, Bin} ->
            if
                Size =:= infinity ->
                    ok;
                Size =/= infinity ->
                    ?assert(Size >= iolist_size(Bin))
            end,
            read_partial_body(Pid, Size, [Acc, Bin])
    end.

simple(Method) ->
    Port = start(gen_tcp, [fun simple_response/5]),
    URL = url(Port, "/simple"),
    {ok, Response} = dlhttpc:request(URL, Method, [], 1000),
    {StatusCode, ReasonPhrase} = status(Response),
    ?assertEqual(200, StatusCode),
    ?assertEqual("OK", ReasonPhrase),
    ?assertEqual(<<?DEFAULT_STRING>>, body(Response)).

url(Port, Path) ->
    "http://localhost:" ++ integer_to_list(Port) ++ Path.

ssl_url(Port, Path) ->
    "https://localhost:" ++ integer_to_list(Port) ++ Path.

status({Status, _, _}) ->
    Status.

body({_, _, Body}) ->
    Body.

headers({_, Headers, _}) ->
    Headers.

%%% Responders
simple_response(Module, Socket, Request, _Headers, Body) ->
    {http_request, _, Uri, _} = Request,
    Path = case Uri of
             {abs_path, Path1} ->
               Path1;
             {absoluteURI, Scheme, Host, undefined, Path1} ->
               atom_to_list(Scheme) ++ "://" ++ Host ++ Path1;
             {absoluteURI, Scheme, Host, Port, Path1} ->
               atom_to_list(Scheme) ++ "://" ++ Host ++ ":" ++ integer_to_list(Port) ++ Path1
           end,
    Module:send(
        Socket,
        [
            "HTTP/1.1 200 OK\r\n"
            "Content-type: text/plain\r\nContent-length: 14\r\n"
            "X-Test-Orig-Uri: ", Path, "\r\n"
            "X-Test-Orig-Body: ", Body, "\r\n\r\n"
            ?DEFAULT_STRING
        ]
    ).

large_response(Module, Socket, _, _, _) ->
    BodyPart = <<?LONG_BODY_PART>>,
    ContentLength = 3 * size(BodyPart),
    Module:send(
        Socket,
        [
            "HTTP/1.1 200 OK\r\n"
            "Content-type: text/plain\r\n"
            "Content-length: ", integer_to_list(ContentLength), "\r\n\r\n"
        ]
    ),
    Module:send(Socket, BodyPart),
    Module:send(Socket, BodyPart),
    Module:send(Socket, BodyPart).

large_chunked_response(Module, Socket, _, _, _) ->
    BodyPart = <<?LONG_BODY_PART>>,
    ChunkSize = erlang:integer_to_list(size(BodyPart), 16),
    Chunk = [ChunkSize, "\r\n", BodyPart, "\r\n"],
    Module:send(
        Socket,
        [
            "HTTP/1.1 200 OK\r\n"
            "Content-type: text/plain\r\n"
            "Transfer-Encoding: chunked\r\n\r\n"
        ]
    ),
    Module:send(Socket, Chunk),
    Module:send(Socket, Chunk),
    Module:send(Socket, Chunk),
    Module:send(Socket, "0\r\n\r\n").

slow_chunked_response(Module, Socket, _, _, _) ->
    ChunkSize = erlang:integer_to_list(length(?LONG_BODY_PART) * 2, 16),
    Module:send(
        Socket,
        [
            "HTTP/1.1 200 OK\r\n"
            "Content-type: text/plain\r\n"
            "Transfer-Encoding: chunked\r\n\r\n"
        ]),
    Module:send(Socket, [ChunkSize, "\r\n", <<?LONG_BODY_PART>>]),
    timer:sleep(200),
    Module:send(Socket, [<<?LONG_BODY_PART>>, "\r\n"]),
    Module:send(Socket, "0\r\n\r\n").


chunked_upload(Module, Socket, _, Headers, <<>>) ->
    TransferEncoding = dlhttpc_lib:header_value("transfer-encoding", Headers),
    {Body, HeadersAndTrailers} =
        webserver:read_chunked(Module, Socket, Headers),
    Trailer1 = dlhttpc_lib:header_value("x-trailer-1", HeadersAndTrailers,
        "undefined"),
    Module:send(
        Socket,
        [
            "HTTP/1.1 200 OK\r\n"
            "Content-Length: 14\r\n"
            "X-Test-Orig-Trailer-1:", Trailer1, "\r\n"
            "X-Test-Orig-Enc: ", TransferEncoding, "\r\n"
            "X-Test-Orig-Body: ", Body, "\r\n\r\n"
            ?DEFAULT_STRING
        ]
    ).

head_response(Module, Socket, _Request, _Headers, _Body) ->
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Server: Test server!\r\n\r\n"
    ).

no_content_response(Module, Socket, _Request, _Headers, _Body) ->
    Module:send(
        Socket,
        "HTTP/1.1 204 OK\r\n"
        "Server: Test server!\r\n\r\n"
    ).

empty_body(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nContent-length: 0\r\n\r\n"
    ).

copy_body(Module, Socket, _, _, Body) ->
    Module:send(
        Socket,
        [
            "HTTP/1.1 200 OK\r\n"
            "Content-type: text/plain\r\nContent-length: "
            ++ integer_to_list(size(Body)) ++ "\r\n\r\n",
            Body
        ]
    ).

copy_body_100_continue(Module, Socket, _, _, Body) ->
    Module:send(
        Socket,
        [
            "HTTP/1.1 100 Continue\r\n\r\n"
            "HTTP/1.1 200 OK\r\n"
            "Content-type: text/plain\r\nContent-length: "
            ++ integer_to_list(size(Body)) ++ "\r\n\r\n",
            Body
        ]
    ).

respond_and_close(Module, Socket, _, _, Body) ->
    Pid = list_to_pid(binary_to_list(Body)),
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Connection: close\r\n"
        "Content-type: text/plain\r\nContent-length: 14\r\n\r\n"
        ?DEFAULT_STRING
    ),
    {error, closed} = Module:recv(Socket, 0),
    Pid ! closed,
    Module:close(Socket).

respond_and_wait(Module, Socket, _, _, Body) ->
    Pid = list_to_pid(binary_to_list(Body)),
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nContent-length: 14\r\n\r\n"
        ?DEFAULT_STRING
    ),
    % We didn't signal a connection close, but we want the client to do that
    % any way
    {error, closed} = Module:recv(Socket, 0),
    Pid ! closed,
    Module:close(Socket).

pre_1_1_server(Module, Socket, _, _, Body) ->
    Pid = list_to_pid(binary_to_list(Body)),
    Module:send(
        Socket,
        "HTTP/1.0 200 OK\r\n"
        "Content-type: text/plain\r\nContent-length: 14\r\n\r\n"
        ?DEFAULT_STRING
    ),
    % We didn't signal a connection close, but we want the client to do that
    % any way since we're 1.0 now
    {error, closed} = Module:recv(Socket, 0),
    Pid ! closed,
    Module:close(Socket).

pre_1_1_server_keep_alive(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.0 200 OK\r\n"
        "Content-type: text/plain\r\n"
        "Connection: Keep-Alive\r\n"
        "Content-length: 14\r\n\r\n"
        ?DEFAULT_STRING
    ).

very_slow_response(Module, Socket, _, _, _) ->
    timer:sleep(1000),
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nContent-length: 14\r\n\r\n"
        ?DEFAULT_STRING
    ).

no_content_length(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nConnection: close\r\n\r\n"
        ?DEFAULT_STRING
    ).

no_content_length_1_0(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.0 200 OK\r\n"
        "Content-type: text/plain\r\n\r\n"
        ?DEFAULT_STRING
    ).

chunked_response(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nTransfer-Encoding: chunked\r\n\r\n"
        "5\r\n"
        "Great\r\n"
        "1\r\n"
        " \r\n"
        "8\r\n"
        "success!\r\n"
        "0\r\n"
        "\r\n"
    ).

chunked_response_t(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nTransfer-Encoding: ChUnKeD\r\n\r\n"
        "7\r\n"
        "Again, \r\n"
        "E\r\n"
        "great success!\r\n"
        "0\r\n"
        "Trailer-1: 1\r\n"
        "Trailer-2: 2\r\n"
        "\r\n"
    ).

close_connection(Module, Socket, _, _, _) ->
    Module:send(
        Socket,
        "HTTP/1.1 200 OK\r\n"
        "Content-type: text/plain\r\nContent-length: 14\r\n\r\n"
    ),
    Module:close(Socket).

not_modified_response(Module, Socket, _Request, _Headers, _Body) ->
    Module:send(
        Socket,
		[
			"HTTP/1.1 304 Not Modified\r\n"
			"Date: Tue, 15 Nov 1994 08:12:31 GMT\r\n\r\n"
		]
    ).
