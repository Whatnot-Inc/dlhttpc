%% coding: latin-1
%%% ----------------------------------------------------------------------------
%%% Copyright (c) 2009, Erlang Training and Consulting Ltd.
%%% Copyright (c) 2012, Frederic Trottier-Hebert
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
%%% @author Fred Hebert <mononcqc@ferd.ca>
%%% @doc Top supervisor for the dlhttpc application.
%%% This is normally started by the application behaviour implemented in
%%% {@link dlhttpc}. An ETS table is started as part of the supervisor's
%%% init function in order to support dispatching.
%%% @end
-module(dlhttpc_sup).
-behaviour(supervisor).

-export([start_link/0, start_link/1]).
-export([init/1]).

%% @spec () -> {ok, pid()} | {error, Reason}
%% Reason = atom()
%% @doc Starts and links to the supervisor.
%% This is normally called from an application behaviour or from another
%% supervisor.
%% @end
-spec start_link() -> {ok, pid()} | {error, atom()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_link(Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Args).

%% @hidden
init(Opts) ->
    init_ets(Opts),
    {ok, {{one_for_one, 10, 1}, []}}.

init_ets(Opts) ->
    ETSOpts = proplists:get_value(ets, Opts, []),
    %% Only option supported so far -- others do not really make sense at this point
    ReadConc = {read_concurrency, proplists:get_value(read_concurrency, ETSOpts, true)},
    ets:new(dlhttpc_disp, [named_table, set, public, ReadConc]).
