-module(afile_server).
-export([start/1,loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
	receive
		{Client, list_dir} ->
			Client ! {self(), file:list_dir(Dir)};
		{Client, {get_file, File}} ->
			Full = filename:join(Dir, File),
			Client ! {self(), file:read_file(Full)};
		{Client, {put_file, File, Contents}} ->
			file:write_file(File, Contents),
			Client ! {self(), "Success?"};
		{Client, {delete_file, File}} ->
			file:delete(File),
			Client ! {self(), "Success??"};
		{Client, {make_dir, DirPath}} ->
			file:make_dir(DirPath),
			Client ! {self(), "Success??"};
		{Client, {rm_dir, Path}} ->
			file:del_dir(Path),
			Client ! {self(), "Success???"}
	end,
	loop(Dir).
	
	

