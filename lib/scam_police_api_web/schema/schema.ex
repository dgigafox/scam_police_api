defmodule ScamPoliceAPIWeb.Schema do
  use Absinthe.Schema
  import_types(ScamPoliceAPIWeb.Schema.ScamsTypes)

  alias ScamPoliceAPIWeb.Resolvers

  query do
    @desc "List reported scams with pagination"
    field :search_scams, :paginated_scams do
      arg(:term, :string)
      arg(:page_size, :integer)
      arg(:page, :integer)
      resolve(&Resolvers.Scams.search_scams/3)
    end
  end

  mutation do
    @desc "Report a scam"
    field :report_scam, type: :scam do
      arg(:link, non_null(:string))
      arg(:description, non_null(:string))
      arg(:email, non_null(:string))
      resolve(&Resolvers.Scams.report_scam/3)
    end
  end
end
