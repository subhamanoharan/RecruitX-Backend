defmodule RecruitxBackend.CandidateControllerTest do
    use RecruitxBackend.ConnCase, async: false

    alias RecruitxBackend.Repo
    alias RecruitxBackend.Candidate

    import Mock

    test "get /candidates returns a list of candidates" do
      candidate = [%{"name" => "test"}]
      with_mock Repo, [all: fn(Candidate) -> candidate end] do
      response = get conn(), "/candidates"

      assert json_response(response, 200) === candidate
      end
    end

  test "POST /candidates with valid post parameters" do
    valid_changeset = %{:valid? => true}
    with_mock Candidate, [changeset: fn(%Candidate{}, _) -> valid_changeset end] do
      with_mock Repo, [insert: fn(valid_changeset) -> true end] do
        conn = post conn(), "/candidates", [name: "test"]

        assert called Repo.insert(valid_changeset)
        assert conn.status == 200
      end
    end
  end

  test "POST /candidates with invalid post parameters" do
    invalid_changeset = %{:valid? => false}
    with_mock Candidate, [changeset: fn(%Candidate{}, _) -> invalid_changeset end] do
      conn = post conn(), "/candidates", [name: "test"]

      assert conn.status == 400
    end
  end
end
