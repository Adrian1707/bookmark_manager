
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

  def sign_up(user)
    visit '/users/new'
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end


end
