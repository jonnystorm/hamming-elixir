defmodule HammingEx.Mixfile do
  use Mix.Project

  def project do
    [app: :hamming_ex,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:jds_math_ex, git: "https://github.com/jonnystorm/jds-math-elixir", ref: "b3f83400c"}]
  end
end
