defmodule ScamPoliceAPIWeb.Schema.ScamsTypes do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload

  object :scam do
    field :id, :id
    field :link, :string
    field :reports, list_of(:report)
    field :verifications, list_of(:verification)
  end

  object :paginated_scams do
    field :entries, list_of(:scam)
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  object :report do
    field :id, :id
    field :email, :string
    field :report, :string
    field :reporter, :string
  end

  object :verification do
    field :id, :id
    field :verified_by, :string
  end

  payload_object(:scam_payload, :scam)
end
