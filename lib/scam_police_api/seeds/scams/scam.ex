defmodule ScamPoliceAPI.Seeds.Scams.Scam do
  @moduledoc false
  alias ScamPoliceAPI.Scams.Scam
  alias Faker.Internet, as: FakerInternet
  alias Faker.Lorem, as: FakerLorem
  alias ScamPoliceAPI.Repo

  def insert! do
    email = FakerInternet.email()

    params = %{
      link: FakerInternet.url(),
      reports: [
        %{
          reporter: FakerInternet.user_name(),
          email: email,
          report: FakerLorem.sentence()
        }
      ],
      verifications: [
        %{
          verified_by: email
        }
      ]
    }

    %Scam{}
    |> Scam.changeset(params)
    |> Repo.insert!()
  end
end
