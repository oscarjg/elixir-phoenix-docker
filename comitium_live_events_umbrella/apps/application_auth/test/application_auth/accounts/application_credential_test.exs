defmodule ApplicationAuth.Accounts.ApplicationCredentialTest do
  use ExUnit.Case, async: true

  test "converts domain hosts to enum" do
    assert ApplicationAuth.Accounts.ApplicationCredential.allowed_hosts_to_enum(%{
             allowed_hosts: "foo,bar"
           }) == ["foo", "bar"]

    assert ApplicationAuth.Accounts.ApplicationCredential.allowed_hosts_to_enum(%{
             allowed_hosts: "foo, bar"
           }) == ["foo", "bar"]

    assert ApplicationAuth.Accounts.ApplicationCredential.allowed_hosts_to_enum(%{allowed_hosts: ""}) ==
             []

    assert ApplicationAuth.Accounts.ApplicationCredential.allowed_hosts_to_enum(%{allowed_hosts: nil}) ==
             []
  end
end
