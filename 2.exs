defmodule Program do
  @intcodes_per_instruction 4

  def execute(opcode, param_1, param_2, target_address, memory, instruction_pointer)

  def execute(1, param_1, param_2, target_address, memory, instruction_pointer) do
    memory = List.replace_at(memory, target_address, Enum.at(memory, param_1) + Enum.at(memory, param_2))
    step(memory, instruction_pointer + @intcodes_per_instruction)
  end

  def execute(2, param_1, param_2, target_address, memory, instruction_pointer) do
    memory = List.replace_at(memory, target_address, Enum.at(memory, param_1) * Enum.at(memory, param_2))
    step(memory, instruction_pointer + @intcodes_per_instruction)
  end

  def execute(99, _, _, _, memory, _) do
    Enum.at(memory, 0)
  end

  def step(memory, instruction_pointer) do
    [opcode, param_1, param_2, target_address] = memory
      |> Enum.drop(instruction_pointer)
      |> Enum.take(@intcodes_per_instruction)
    execute(opcode, param_1, param_2, target_address, memory, instruction_pointer)
  end

  def restore(memory, noun, verb) do
    memory
      |> List.replace_at(1, noun)
      |> List.replace_at(2, verb)
  end
end

memory = File.read!("2_input.txt")
  |> String.split(",")
  |> Stream.map(&String.trim_trailing/1)
  |> Enum.map(&String.to_integer/1)

# Part 1

memory
  |> Program.restore(12, 2)
  |> Program.step(0)
  |> IO.inspect

# Part 2

combinations = for verb <- 0..99, noun <- 0..99, do: {verb, noun}

result =
  Enum.reduce_while(combinations, nil, fn {noun, verb}, _ ->
    output = memory
      |> Program.restore(noun, verb)
      |> Program.step(0)

    if output == 19690720 do
      {:halt, 100 * noun + verb}
    else
      {:cont, nil}
    end
  end)

IO.inspect(result)
