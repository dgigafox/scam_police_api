defmodule ScamPoliceAPIWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(__MODULE__.AccountsTypes)
  import_types(__MODULE__.ScamsTypes)
  import_types(AbsintheErrorPayload.ValidationMessageTypes)
  import AbsintheErrorPayload.Payload

  alias ScamPoliceAPIWeb.Resolvers
  alias ScamPoliceAPIWeb.Middlewares.Authentication

  query do
    @desc "List reported scams with pagination"
    field :search_scams, :paginated_scams do
      arg(:term, :string)
      arg(:page_size, :integer)
      arg(:page, :integer)
      resolve(&Resolvers.Scams.search_scams/3)
    end

    @desc "List reports with pagination"
    field :list_reports, :paginated_reports do
      arg(:page_size, :integer)
      arg(:page, :integer)
      arg(:scam_id, :id)
      resolve(&Resolvers.Scams.list_reports/3)
    end

    @desc "List verifications with pagination"
    field :list_verifications, :paginated_verifications do
      arg(:page_size, :integer)
      arg(:page, :integer)
      arg(:scam_id, :id)
      resolve(&Resolvers.Scams.list_verifications/3)
    end

    @desc "Get reported scam"
    field :get_scam, :scam do
      arg(:id, :integer)
      resolve(&Resolvers.Scams.get_scam/3)
    end

    @desc "Verify if a URL is valid"
    field :is_valid_url, :boolean do
      arg(:link, non_null(:string))
      resolve(&Resolvers.Scams.is_valid_url/3)
    end

    @desc "Verify if a scam is verified by the current user"
    field :is_scam_verified, :boolean do
      arg(:scam_id, non_null(:id))
      middleware(Authentication)
      resolve(&Resolvers.Scams.is_scam_verified/3)
    end
  end

  mutation do
    @desc "Report a scam"
    field :report_scam, type: :scam_payload do
      arg(:link, non_null(:string))
      arg(:description, non_null(:string))
      middleware(Authentication)
      resolve(&Resolvers.Scams.report_scam/3)
      middleware(&build_payload/2)
    end

    @desc "Create a report"
    field :create_report, type: :report_payload do
      arg(:report, non_null(:string))
      arg(:scam_id, non_null(:id))
      middleware(Authentication)
      resolve(&Resolvers.Scams.create_report/3)
      middleware(&build_payload/2)
    end

    @desc "Register user"
    field :register_user, type: :user_credential_payload do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))
      arg(:nickname, :string)
      resolve(&Resolvers.Accounts.register_user/3)
      middleware(&build_payload/2)
    end

    @desc "Login user"
    field :login_user, type: :user_credential_payload do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.login_user/3)
      middleware(&build_payload/2)
    end
  end
end
