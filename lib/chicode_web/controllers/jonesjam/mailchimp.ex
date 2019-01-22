defmodule Mailchimp do
  @api_uri "https://us18.api.mailchimp.com/3.0"
  @list_endpoint @api_uri <> "/lists/" <> Application.get_env(:chicode, :mailchimp_list_id)

  def add({:ok, user}) do
    headers = [
      {"Authorization", "apikey #{Application.get_env(:chicode, :mailchimp_key)}"},
      {"Content-Type", "application/json"}
    ]

    body = %{
      members: [
        %{
          email_address: user.email,
          status: "subscribed"
        }
      ]
    }

    HTTPoison.post(@list_endpoint, Jason.encode!(body), headers) do
  end
end
