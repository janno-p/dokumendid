class UserAccount < ActiveRecord::Base
  self.table_name = "user_account"
  self.primary_key = "user_account"

  def readonly?
    true
  end

  def self.authenticate(name, password)
    user = self.find_by_username(name)
    return nil unless user
    expected_password = encrypted_password(password)
    return nil unless user.passw == expected_password
    user
  end

  private

  def self.encrypted_password(password)
    Digest::SHA1.hexdigest(password)
  end
end
