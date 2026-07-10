class AuthenticationService
  def self.authenticate(model:, login:, password:, field:)
    login = login.to_s.strip

    login.downcase! if field == :email

    actor = model.find_by(field => login)

    return nil unless actor
    return nil unless actor.authenticate(password)

    actor
  end
end