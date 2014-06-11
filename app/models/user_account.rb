# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class UserAccount < ActiveRecord::Base
  self.table_name = "user_account"
  self.primary_key = "user_account"

  belongs_to :employee, foreign_key: "subject_fk"

  def readonly?
    true
  end

  def self.authenticate(name, password)
    expected_password = encrypted_password(password)
    user = self.where("username = ? and passw = ?", name, expected_password).first
    user
  end

  def employee?
    subject_type_fk == 3
  end

  private

  def self.encrypted_password(password)
    Digest::SHA1.hexdigest(password)
  end
end
