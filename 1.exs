File.stream!("1_input.txt") \
  |> Stream.map(&String.trim_trailing/1) \
  |> Stream.map(&Integer.parse/1) \
  |> Stream.map(&Kernel.elem(&1, 0)) \
  |> Stream.map(fn (mass) -> Float.floor(mass / 3) - 2 end) \
  |> Enum.sum \
  |> IO.puts
