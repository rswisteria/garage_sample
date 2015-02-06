Garage.configure {}
Garage::TokenScope.configure {
  register :public, desc: 'accessing publicly availabledata' do
    access :read, User
    access :write, User
  end
}

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes("Garage::TokenScope.optional_scopes")

  resource_owner_from_credentials do |routes|
    User.find_by(email: params[:username])
  end
end