class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :hello

  def hello
    "world"
  end
end
