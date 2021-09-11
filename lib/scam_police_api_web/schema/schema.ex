defmodule ScamPoliceAPIWeb.Schema do
  use Absinthe.Schema
  import_types(ScamPoliceAPIWeb.Schema.ScamsTypes)
  import AbsintheErrorPayload.Payload

  alias ScamPoliceAPIWeb.Resolvers

  query do
    @desc "List reported scams with pagination"
    field :search_scams, :paginated_scams do
      arg(:term, :string)
      arg(:page_size, :integer)
      arg(:page, :integer)
      resolve(&Resolvers.Scams.search_scams/3)
    end

    @desc "Get reported scam"
    field :get_scam, :scam do
      arg(:id, :integer)
      resolve(&Resolvers.Scams.get_scam/3)
    end
  end

  mutation do
    @desc "Report a scam"
    field :report_scam, type: :scam_payload do
      arg(:link, non_null(:string))
      arg(:description, non_null(:string))
      arg(:email, non_null(:string))
      resolve(&Resolvers.Scams.report_scam/3)
      middleware(&build_payload/2)
    end
  end
end
