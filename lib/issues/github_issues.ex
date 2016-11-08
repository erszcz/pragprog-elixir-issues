defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir radoslaw.szymczyszyn@erlang-solutions.com"} ]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @github_url Application.get_env(:issues, :github_url)
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}
  def handle_response({:ok, %{status_code: ___, body: body}}), do: {:error, body}
end
