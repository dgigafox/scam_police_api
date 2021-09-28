defmodule ScamPoliceAPIWeb.Schema.ScamsTypes do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload

  object :scam do
    field :id, :id
    field :link, :string
    field :reports, list_of(:report)
    field :verifications, list_of(:verification)
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
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
    field :report, :string
    field :reporter, :user
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :paginated_reports do
    field :entries, list_of(:report)
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  object :verification do
    field :id, :id
    field :verified_by, :user
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :paginated_verifications do
    field :entries, list_of(:verification)
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  payload_object(:report_payload, :report)
  payload_object(:scam_payload, :scam)
end
