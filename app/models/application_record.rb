class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.looks(searaches,word)
    column = (self == User ? 'name' : 'title')
    
    if searaches == "forward_match"
      self.where("#{column} LIKE?","#{word}%")
    elsif searaches == "backward_match"
      self.where("#{column} LIKE?","%#{word}")
    elsif searaches== "perfect_match"
      self.where("#{column} = ?","#{word}")
    elsif searaches == "partial_match"
      self.where("#{column} LIKE?","%#{word}%")
    else
      self.all
    end
  end
end
