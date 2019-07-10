defmodule PServer.Accounts.Encryption do
  alias Argon2
  def hash_password(password), do: Argon2.hash_pwd_salt(password)
  def validate_password(password, hash), do: Argon2.verify_pass(password, hash)
end
