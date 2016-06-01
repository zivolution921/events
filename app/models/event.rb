class Event < ActiveRecord::Base
  #rails must pass all validations in order to save into the database
  validates :name, :location, presence: true
  
  validates :description, length: { minimum: 25 }

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  # must pass this format at least one word and "." gif jpg or png 
  validates :image_file_name, allow_blank: true, format: {
  # at least one word character and "." and gif or jpg or png
    with:    /\w+\.(gif|jpg|png)\z/i,
  # costume message override default message
    message: "must reference a GIF, JPG, or PNG image"
  }

  validate :price_is_a_multiple_of_fifty_cents
  
  # rails generates methods to manage events registration
  # rails will destroy each child when the parent object is destroyed
  has_many :registrations, dependent: :destroy

  has_many :likes, dependent: :destroy
  # associate event and user through likes table using inner join
  # the source is the user
  has_many :likers, through: :likes, source: :user
  
  has_many :categorizations, dependent: :destroy
  # event to assign categories through association let choose category_ids and able to assign multiple categories
  has_many :categories, through: :categorizations
  
  accepts_nested_attributes_for :categories

  def self.upcoming
    where('starts_at >= ?', Time.now).order(:starts_at)
  end
  
  def self.inexpensive
    # Event.where('price <= ?')
    where('price <= 15').order('price DESC')
  end
  # business logic to define if event is free  
  def free?
    price.blank? || price.zero?
  end  
  
  def spots_left
    if capacity.zero?
      0
    else
      capacity - registrations.size
    end
  end
  
  # boolean to check if sold_out or not
  def sold_out?
    spots_left.zero?
  end
  
private

  def price_is_a_multiple_of_fifty_cents
    if errors[:price].empty?
      # unless (price * 100).remainder(50) == 0
      unless (price * 100) % 50 == 0
        errors[:price] << "must be a multiple of fifty cents"
      end
    end
  end

end
