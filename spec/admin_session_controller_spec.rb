describe AdminSessionController, type: :controller do

  before do
    @admin = Admin.create(login: "testadmin", password: "testadmin", site_title: "Title Test", site_description: "Description Test")
  end

  it "create_and_destroy_session" do
    sign_out

    post :create, params: {session: {login: 'testadmin', password: 'testadmin'}}
    expect(current_admin).to eq(@admin)
    delete :destroy
    expect(current_admin).to eq(nil)

    sign_out
  end

  it "try to create a session without sign out" do
    admin_sign_in "testlogin", "testpassword"

    post :create, params: {session: {login: 'testadmin', password: 'testadmin'}}
    expect(current_admin).to eq(nil)

    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {session: {login: 'testadmin', password: 'testadmin'}}
    expect(current_admin).to eq(nil)

    sign_out
  end

  it "try to create a session with wrong login or password" do
    sign_out

    post :create, params: {session: {login: 'error', password: 'testadmin'}}
    expect(current_admin).to eq(nil)

    post :create, params: {session: {login: 'testadmin', password: 'error'}}
    expect(current_admin).to eq(nil)

    post :create, params: {session: {login: 'error', password: 'error'}}
    expect(current_admin).to eq(nil)

    sign_out
  end

end
