defmodule Hamming.Dot do
  defp edge(x, y) do
    "#{x} -- #{y};"
  end

  def edges_to_dot(edges) do
    edges
      |> Enum.sort
      |> Enum.map(fn {x, y} -> edge(x, y) <> "\n" end)
  end

  @spec hamming_cube_edges(pos_integer) :: list
  def hamming_cube_edges(dimension \\ 4) do
    max_num = BitMath.pow_2(dimension) - 1

    (for i <- 0..max_num,
         j <- BitMath.hamming_shell(i, 1, dimension) do
      {min(i, j), max(i, j)}
    end) |> Enum.uniq
  end

  @spec hamming_sphere_edges(integer, pos_integer, pos_integer) :: list
  def hamming_sphere_edges(center, radius, dimensions) do
    sphere = BitMath.hamming_sphere(center, radius, dimensions)

    (for p <- sphere,
         q <- sphere,
         BitMath.hamming_distance(p, q) == 1 do
      {min(p, q), max(p, q)}
    end) |> Enum.uniq
  end

  def print_hamming_sphere_graph do
    IO.puts """
    graph G {"
      node [colorscheme=oranges6];
      edge [color=transparent len=4];

    """

    for node <- (BitMath.hamming_sphere(0, 4, 8) |> Enum.sort) do
      color = BitMath.hamming_distance(0, node) + 1
      IO.puts("  #{node} [style=filled fillcolor=#{color}];")
    end

    Dot.hamming_sphere_edges(0, 4, 8)
      |> Dot.edges_to_dot
      |> IO.puts
    IO.puts "}"
  end
end

