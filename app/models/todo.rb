class Todo < ActiveRecord::Base
  attr_accessible :done, :todo, :user_id
  
  belongs_to :user
  
  has_and_belongs_to_many :tags
  
  paginates_per 5
  
  validates :todo, presence: true
  
  # Want to initialize done to false (i.e. incomplete task)
  after_initialize :default_values
  def default_values
    # Set if not nil
    self.done ||= false
  end
  
  def add_tag_with_id(new_tag_id)
    # The 'new_tag_id' is 0 if no new tag to add, and the tag_id of a new tag otherwise
    new_tag = Tag.find_by_id(new_tag_id)
    
    # If the tag exists and is not already present
    if (new_tag) && (self.tags.where(id: new_tag_id).present? == false)
      self.tags << new_tag
    end
  end
  
  def remaining_tags
    # Get all tags owned by this user, not including tags currently used by this Todo
    self.user.tags - self.tags
  end

  def tags_comma_list
    string = ''
    self.tags.each_with_index do |tag, index|
      if index > 0
        string += ', '
      end
      string += tag.title
    end
    string
  end
end
