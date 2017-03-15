class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :hello, :auth_token

  def hello
    "world"
  end
end
