-module(c13).
-export([my_spawn/3
	,restart_test/0
	,loop/0
	,start/0
	,run_monitor/1
	,stop/0
	,send_error/0]).


restart_test() ->
	spawn_on_exit_and_restart(?MODULE,loop,[]).



my_spawn(Mod, Fun, Args) ->
	Pid = spawn(Mod, Fun, Args),
	{_,Start,_} = now(),
	spawn(fun() ->
		Ref = monitor(process, Pid),
		receive
			{'DOWN', Ref, process, Pid, Why} ->
				{_,End,_} = now(),
				io:format("Process has exited after ~p seconds~n",[End - Start])
			end
	      end),
	Pid.


spawn_on_exit_and_restart(Mod, Fun, Args) ->
	Pid = spawn(Mod, Fun, Args),
	{_,StartSeconds,_} = now(),
	on_exit(Pid, fun(Start) ->
			{_,End,_} = now(),
			io:format("Process has exited after ~p seconds~n",[End - Start]),
		    	spawn_on_exit_and_restart(Mod, Fun, Args)
		     end, StartSeconds),
			
	Pid.


loop() ->
	receive
		X -> list_to_atom(X)
	end,
	loop().



on_exit(Pid, Fun, StartTime) ->
	spawn(fun() ->
			Ref = monitor(process, Pid),
			receive
				{'DOWN', Ref, process, Pid, Why} ->
					Fun(StartTime)
			end
		end).


start() -> 
	register(runner, Pid = spawn(fun() -> running() end)),
	Pid.

run_monitor(P) ->
	spawn(fun() ->
	      	Ref = monitor(process, P),
		receive
			{'DOWN', Ref, process, P, Why} ->
				case Why =:= normal of
					true ->
						io:format("stopping process~n",[]);
					false ->
						io:format("restarting because ~p~n",[Why]),
						Pid = start(),
					        run_monitor(Pid)	% how to start with the time param that was passed???
				end
		end
	end).
	

stop() ->
       	runner ! stop.

send_error() -> 
	runner ! error.

running()->
	receive
		stop ->
			void;
		error ->
			exit("error")	
	after 5000 ->
		io:format("Still running!~n",[]),
		running()
	end.
