# defmodule ElixirTutor.Watcher do
#   use GenServer

#   def start_link(args \\ []) do
#     GenServer.start_link(__MODULE__, args, name: :tutor)
#   end

#   def init(_args \\ []) do
#     {:ok, pid} = FileSystem.start_link(dirs: [Path.absname("exercises/")])
#     FileSystem.subscribe(pid)
#     {:ok, pid}
#   end

#   def handle_call

#   def handle_cast

#   def handle_info(
#         {:file_event, _watcher_pid, {path, events}},
#         %{watcher_pid: watcher_pid} = state
#       ) do
#     # Your own logic for path and events
#     IO.puts("#{inspect(events)}")
#     {:noreply, state}
#   end

#   def handle_info(
#         {:file_event, watcher_pid, :stop},
#         %{watcher_pid: watcher_pid} = state
#       ) do
#     # Your own logic when monitor stop
#     {:noreply, state}
#   end
# end
