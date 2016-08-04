class Album < ActiveRecord::Base
  validates :title, :band_id, presence: true
end
