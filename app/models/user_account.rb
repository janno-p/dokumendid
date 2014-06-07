class UserAccount < ActiveRecord::Base
  self.table_name = "user_account"
  self.primary_key = "user_account"

  belongs_to :employee, foreign_key: "subject_fk"

  def readonly?
    true
  end

  def self.authenticate(name, password)
    expected_password = encrypted_password(password)
    user = self.where("subject_type_fk = ? and username = ? and passw = ?", 3, name, expected_password).first
    user
  end

  private

  def self.encrypted_password(password)
    Digest::SHA1.hexdigest(password)
  end
end
