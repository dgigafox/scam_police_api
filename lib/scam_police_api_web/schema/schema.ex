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
end
