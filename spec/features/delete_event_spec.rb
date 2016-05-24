require 'rails_helper'

describe "Deleting an event" do 
  it "destroys the event and shows the event listing" do
    event = Event.create(event_attributes)
    
    visit event_path(event)
    
    click_link 'Delete'
    
    #expect { click_link "Delete" }.to change(Event, :count).by(-1)
    
    expect(current_path).to eq(events_path)
    expect(page).not_to have_text(event.name)
    expect(page).to have_text('Event successfully deleted!')
  end
end
