describe PhotosController, type: :controller do

  it "create_photo" do
    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {photo: {title: 'photo test', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#test1 #test2 #test3'}}
    expect(Photo.last.contributor.login).to eq("testlogin")
    expect(Photo.last.title).to eq('photo test')
    expect(Photo.last.description).to eq('')
    expect(Photo.last.tag_list_temp).to eq('#test1 #test2 #test3')
    expect(Photo.last.tags.count).to eq(3)
    expect(Tag.find_by(name: "test1").nil?).to eq(false)
    expect(Tag.find_by(name: "test2").nil?).to eq(false)
    expect(Tag.find_by(name: "test3").nil?).to eq(false)

    admin_sign_in "testlogin", "testpassword"

    post :create, params: {photo: {title: 'photo fail', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: ''}}
    expect(Photo.find_by(title: 'photo fail')).to be(nil)

    sign_out

    post :create, params: {photo: {title: 'photo fail', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: ''}}
    expect(Photo.find_by(title: 'photo fail')).to be(nil)
  end

  it "edit_photo" do
    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {photo: {title: 'photo test', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#test4 #test5 #test6'}}
    patch :update, params: {photo_id: Photo.last.id, photo: {title: 'photo test 2', description: 'edited', tag_list_temp: '#test4 #test7'}}
    expect(Photo.last.contributor.login).to eq("testlogin")
    expect(Photo.last.title).to eq('photo test 2')
    expect(Photo.last.description).to eq('edited')
    expect(Photo.last.tag_list_temp).to eq('#test4 #test7')
    expect(Photo.last.tags.count).to eq(2)
    expect(Tag.find_by(name: "test4").nil?).to eq(false)
    expect(Tag.find_by(name: "test5").nil?).to eq(true)
    expect(Tag.find_by(name: "test6").nil?).to eq(true)
    expect(Tag.find_by(name: "test7").nil?).to eq(false)

    admin_sign_in "testlogin", "testpassword"

    patch :update, params: {photo_id: Photo.last, photo: {title: 'photo fail', description: '', tag_list_temp: ''}}
    expect(Photo.find_by(title: 'photo fail')).to be(nil)

    sign_out

    patch :update, params: {photo_id: Photo.last, photo: {title: 'photo fail', description: '', tag_list_temp: ''}}
    expect(Photo.find_by(title: 'photo fail')).to be(nil)
  end

  it "delete_photo" do
    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {photo: {title: 'photo to be deleted', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#testtobedeleted'}}
    delete :delete, params: {photo_id: Photo.last.id}
    expect(Photo.find_by(title: 'photo to be deleted').nil?).to eq(true)
    expect(Tag.find_by(name: 'testtobedeleted').nil?).to eq(true)

    post :create, params: {photo: {title: 'photo to be deleted', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#testtobedeleted'}}
    photo_last_id = Photo.last.id

    sign_out

    delete :delete, params: {photo_id: photo_last_id}
    expect(Photo.find_by(title: 'photo to be deleted')).not_to eq(nil)

    admin_sign_in "testlogin", "testpassword"

    delete :delete, params: {photo_id: photo_last_id}
    expect(Photo.find_by(title: 'photo to be deleted')).to eq(nil)

    sign_out
  end

  it "uniq tags" do
    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {photo: {title: 'photo test', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#test8 #test8 #test8'}}
    expect(Photo.last.tag_list_temp).to eq('#test8')
    expect(Photo.last.tags.count).to eq(1)

    sign_out
  end

  it "do not delete tags being used" do
    contributor_sign_in "testlogin", "testpassword"

    post :create, params: {photo: {title: 'photo test', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#test9 #test10 #test11'}}
    post :create, params: {photo: {title: 'photo test', description: '', image: Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'image/png'), tag_list_temp: '#test10 #test11 #test12'}}
    patch :update, params: {photo_id: Photo.last.id, photo: {title: 'photo test 2', description: 'edited', tag_list_temp: ''}}
    expect(Tag.find_by(name: "test10").nil?).to eq(false)
    expect(Tag.find_by(name: "test11").nil?).to eq(false)
    expect(Tag.find_by(name: "test12").nil?).to eq(true)
    patch :update, params: {photo_id: Photo.last.id, photo: {title: 'photo test 2', description: 'edited', tag_list_temp: '#test10 #test11 #test12'}}
    delete :delete, params: {photo_id: Photo.last.id}
    expect(Tag.find_by(name: "test10").nil?).to eq(false)
    expect(Tag.find_by(name: "test11").nil?).to eq(false)
    expect(Tag.find_by(name: "test12").nil?).to eq(true)

    sign_out
  end

end
