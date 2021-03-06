defmodule RecruitxBackend.CandidateIntegrationTest do

    use RecruitxBackend.ConnCase, async: false
    @moduletag :integration
    alias RecruitxBackend.Candidate
    alias RecruitxBackend.Repo

    setup do
        Mix.Tasks.Ecto.Migrate.run(["--all", "Candidate.Repo"])

        on_exit fn ->
            Mix.Tasks.Ecto.Rollback.run(["--all", "Candidate.Repo"])
        end
    end

    test "get /candidates returns a list of candidates" do
        candidate = %{"name" => "test"}
        Repo.insert(Candidate.changeset(%Candidate{}, candidate))

        response = get conn(), "/candidates"

        assert json_response(response, 200) === [candidate]
    end

    test "POST /candidates with valid post parameters" do
        conn = post conn(), "/candidates", [name: "test"]
        assert conn.status == 200
    end

    test "POST /candidates with invalid post parameters should return 400(Bad Request)" do
        conn = post conn(), "/candidates", [invalid: "invalid_post_param"]
        assert conn.status == 400
    end

    test "POST /candidates with no post parameters should return 400(Bad Request)" do
        conn = post conn(), "/candidates"
        assert conn.status == 400
    end
end
