defmodule Rocket do
  def calculate_fuel(mass) do
    fuel = Float.floor(mass / 3) - 2
    if fuel >= 0, do: fuel + calculate_fuel(fuel), else: 0
  end
end

File.stream!("1_input.txt") \
  |> Stream.map(&String.trim_trailing/1) \
  |> Stream.map(&Integer.parse/1) \
  |> Stream.map(&Kernel.elem(&1, 0)) \
  |> Stream.map(&Rocket.calculate_fuel/1) \
  |> Enum.sum \
  |> IO.puts
