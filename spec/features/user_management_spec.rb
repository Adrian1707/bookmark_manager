feature 'User sign in' do

  let (:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end

  scenario 'with correct credentials' do
    sign_in(user)
    expect(page).to have_content "Welcome, user@example.com"
  end

end

feature 'User signs out' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  let (:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end

  scenario 'while being signed in' do
    sign_in(user)
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end

feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = User.new(email: 'email', password: 'password', password_confirmation: 'password')
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, email')
    expect(User.first.email).to eq('email')
  end

  scenario 'requires a matching confirmation password' do
    user = User.create(email: 'email', password: 'password', password_confirmation: 'sdsdsf')
    expect{ sign_up(user) }.not_to change(User, :count)
  end

  scenario 'requires an email to register user' do
    user = User.create(email: nil , password: 'password', password_confirmation: 'password')
    expect{ sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eql('/users')
  end

  scenario 'I cannot sign up with an existing email' do
    user = User.create(email: 'email', password: 'password', password_confirmation: 'password')
    sign_up(user)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end

  scenario 'with a password that does not match' do
    user = User.create(email: 'email', password: 'password', password_confirmation: 'qwdqdq')
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

end
