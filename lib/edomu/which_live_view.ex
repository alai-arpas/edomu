defmodule Edomu.WhichLiveView do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def set(pid) do
    Agent.update(__MODULE__, fn _stato -> pid end)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def is_alive do
    Agent.get(__MODULE__, fn pid -> Process.alive?(pid) end)
  end
end
