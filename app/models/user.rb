# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string
#  password           :string
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#

class User < ActiveRecord::Base
  include Clearance::User
  has_one :chart
end
