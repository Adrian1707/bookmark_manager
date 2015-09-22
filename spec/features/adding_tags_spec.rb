feature 'Adding tags' do

  scenario "I can add a single tag to a new link" do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag', with: 'education'
    click_button 'Add link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
    end

    scenario 'I can filter links by tag' do
      visit '/tags/bubbles'
      within 'ul#links' do
        expect(page).not_to have_content('Makers Academy')
        expect(page).not_to have_content('Code.org')
        expect(page).to have_content('This is Zombocom')
        expect(page).to have_content('Bubble Bobble')
    end


end
