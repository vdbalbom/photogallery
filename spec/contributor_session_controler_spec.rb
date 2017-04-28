describe ContributorSessionController, type: :controller do

  before do
    @contributor = Contributor.create(name: "testcontributor", login: "testcontributor", password: "testcontributor", email: "testcontributor@example.com")
  end

  it "create and destroy session" do
    sign_out

    post :create, params: {session: {login: 'testcontributor', password: 'testcontributor'}}
    expect(current_contributor).to eq(@contributor)
    delete :destroy
    expect(current_contributor.nil?).to eq(true)

    sign_out
  end

  it "try to create a session without sign out" do
    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {session: {login: 'testcontributor', password: 'testcontributor'}}
    expect(current_contributor).to eq(nil)

    admin_sign_in "testlogin", "testpassword"

    post :create, params: {session: {login: 'testcontributor', password: 'testcontributor'}}
    expect(current_contributor).to eq(nil)

    sign_out
  end

  it "try to create a session with wrong login or password" do
    sign_out

    post :create, params: {session: {login: 'error', password: 'testcontributor'}}
    expect(current_contributor).to eq(nil)

    post :create, params: {session: {login: 'testcontributor', password: 'error'}}
    expect(current_contributor).to eq(nil)

    post :create, params: {session: {login: 'error', password: 'error'}}
    expect(current_contributor).to eq(nil)

    sign_out
  end

end
