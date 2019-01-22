defmodule Mailchimp do
  @api_uri "https://us18.api.mailchimp.com/3.0/lists/"

  def add(email, list) do
    headers = [
      {"Authorization", "apikey #{Application.get_env(:chicode, :mailchimp_key)}"},
      {"Content-Type", "application/json"}
    ]

    body = %{
      members: [
        %{
          email_address: email,
          status: "subscribed"
        }
      ]
    }

    uri =
      @api_uri <>
        Application.get_env(
          :chicode,
          case list do
            :chicode -> :chicode_list_id
            :jonesjam -> :jonesjam_list_id
            _ -> raise "List type does not exist"
          end
        )

    HTTPoison.post(uri, Jason.encode!(body), headers)
  end
end
