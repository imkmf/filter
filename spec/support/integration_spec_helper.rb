module IntegrationSpecHelper
  def login_with_oauth(service = :soundcloud)
    visit "/auth/#{service}"
  end
end
