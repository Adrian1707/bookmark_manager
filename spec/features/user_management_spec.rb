
feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    expect{ sign_up(password_confirmation: 'wrong password') }.not_to change(User, :count)
  end

  scenario 'requires an email to register user' do
    expect{ sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eql('/users')
    expect(page).to have_content("Please enter a valid email address")
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up_as(user)
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end

  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong password') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  def sign_up(email: 'alice@example.com',
              password: '12345678',
              password_confirmation: '12345678')
    visit '/users/new'
    fill_in :email,    with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end


end
