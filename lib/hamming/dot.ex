defmodule Hamming.Dot do
  alias Math.Binary

  defp edge_to_dot({p, q}) do
    "#{p} -- #{q};\n"
  end

  @spec hamming_cube_edges(pos_integer) :: list
  def hamming_cube_edges(dimensions \\ 4) do
    max_num = Binary.pow2(dimensions) - 1

    (for p <- 0..max_num,
         q <- Binary.hamming_shell(p, 1, dimensions) do
      {min(p, q), max(p, q)}
    end) |> Enum.uniq
  end

  @spec hamming_sphere_edges(integer, pos_integer, pos_integer) :: list
  def hamming_sphere_edges(center, radius, dimensions) do
    sphere = Binary.hamming_sphere(center, radius, dimensions)

    (for p <- sphere,
         q <- sphere,
         Binary.hamming_distance(p, q) == 1 do
      {min(p, q), max(p, q)}
    end) |> Enum.uniq
  end

  @spec print_graph([integer], [{integer, integer}]) :: String.t
  def print_graph(nodes, edges) do
    IO.puts """
    graph G {"
      node [colorscheme=oranges6];
      edge [color=transparent len=4];

    """

    for node <- (nodes |> Enum.sort) do
      color = Binary.hamming_distance(0, node) + 1
      IO.puts("  #{node} [style=filled fillcolor=#{color}];")
    end

    edges
    |> Enum.sort
    |> Enum.map(&(edge_to_dot &1))
    |> IO.puts

    IO.puts "}"
  end

  @spec print_hamming_sphere_graph(integer, pos_integer, pos_integer) :: String.t
  def print_hamming_sphere_graph(center, radius, dimensions) do
    nodes = Binary.hamming_sphere(center, radius, dimensions)
    edges = hamming_sphere_edges(center, radius, dimensions)

    print_graph(nodes, edges)
  end

  @spec print_hamming_cube_graph(pos_integer) :: String.t
  def print_hamming_cube_graph(dimensions) do
    nodes = Binary.hamming_cube(dimensions)
    edges = hamming_cube_edges(dimensions)

    print_graph(nodes, edges)
  end
end

