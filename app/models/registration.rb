class Registration < ActiveRecord::Base
  # event_id hold reference to event object
  # registration can access the associated event
  # rails dynamically make methods for registration associated event such as reading and writing a registration event
  belongs_to :event
  # foreign key in registration table
  belongs_to :user
  # assign event to registration and get the event from registration
  
  # validates :name, presence: true
  
  # validates :email, format: { with: /(\S+)@(\S+)/ }

  HOW_HEARD_OPTIONS = [ 
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]
  # validates on how_heard attribute inclusion in the array
  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
