-module(afile_client).
-export([ls/1, get_file/2, put_file/3, delete_file/2
		,make_dir/2, rm_dir/2]).

ls(Server) ->
	Server ! {self(), list_dir},
	receive
		{Server, FileList} ->
			FileList
	end.

get_file(Server, File) ->
	Server ! {self(), {get_file, File}},
	receive
		{Server, Content} ->
			Content
	end.

put_file(Server, File, Contents) ->
	Server ! {self(), {put_file, File, Contents}},
	receive
		{Server, Response} ->
			Response	
	end.

delete_file(Server, File) ->
	Server ! {self(), {delete_file, File}},
	receive
		{Server, Response} ->
			Response	
	end.

make_dir(Server, DirPath) ->
	Server ! {self(), {make_dir, DirPath}},
	receive
		{Server, Response} ->
			Response
	end.

rm_dir(Server, Path) ->
	Server ! {self(), {rm_dir, Path}},
	receive
		{Server, Response} ->
			Response	
	end.
